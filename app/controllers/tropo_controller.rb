class TropoController < ApplicationController
  respond_to :json
  layout false

  def receive
    body = params["session"]["initialText"]
    from = params["session"]["from"]["id"]
    to = params["session"]["to"]["id"]

    @message = ResponseManager.new(from, to).step(body)
    puts @message
    t = Tropo::Generator.new
    t.say(:value => @message)
    render :json => t.response
  end
end
