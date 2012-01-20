class ContainsWordAlert < Alert
  attr_accessor :client

  def client
    @client ||= Ask::TwilioClient
    @client
  end

  def check!(answer)
    run!(answer) if answer.text.include?(keyword)
  end

  def keyword
    options[:keyword]
  end

  def run!(answer)
    body = "Keyword \"#{keyword}\" found in response \"#{answer.text}\"!"
    while (segment = body.slice!(0, 160)).length > 0
      options[:recipients].each do |recipient|
        self.client.account.sms.messages.create({
          :to => recipient,
          :from => answer.response.segment.phone_number,
          :body => segment
        })
      end
    end
  end
end
