class ContainsWordAlert < Alert
  attr_accessor :client

  def client
    @client ||= Ask::TwilioClient
    @client
  end

  def check!(answer)
    puts answer.text
    run!(answer) if answer.text.include?(keyword)
  end

  def keyword
    options[:keyword]
  end

  def run!(answer)
    options[:recipients].each do |recipient|
      self.client.account.sms.messages.create({
        :to => recipient,
        :from => answer.response.segment.phone_number,
        :body => "Keyword \"#{keyword}\" found in response \"#{answer.text}\"!"
      })
    end
  end
end
