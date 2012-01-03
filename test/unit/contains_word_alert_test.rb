require 'test_helper'

class ContainsWordAlertTest < ActiveSupport::TestCase
  def setup
    @alert = FactoryGirl.build(:contains_word_alert, :options => {:keyword => 'mockingjay', :recipients => ['1112223333', '1112223334']})
  end

  def test_smses_are_sent_when_the_answer_includes_the_keyword
    @answer = FactoryGirl.create(:answer, :text => "I am the mockingjay.")

    Ask::TwilioClient.account.sms.messages.expects(:create).with({
      :to => "1112223333",
      :from => @answer.survey.phone_number,
      :body => 'Keyword "mockingjay" found in response "I am the mockingjay."!'
    }).returns(true)
    Ask::TwilioClient.account.sms.messages.expects(:create).with({
      :to => "1112223334",
      :from => @answer.survey.phone_number,
      :body => 'Keyword "mockingjay" found in response "I am the mockingjay."!'
    }).returns(true)

    @alert.check!(@answer)
  end

  test "smses are not sent when the answer doesn't include the keyword" do
    Ask::TwilioClient.account.sms.messages.expects(:create).never
    @answer = FactoryGirl.create(:answer, :text => "I thought we agreed not to lie to each other, miss Everdeen.")
    @alert.check!(@answer)
  end
end
