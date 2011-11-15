class TropoController < ApplicationController
  respond_to :json
  layout false

  def receive
    body = params["session"]["initialText"]
    from = params["session"]["from"]["id"]
    to = params["session"]["to"]["id"]

    @manager = ResponseManager.new(from, to)
    @manager.step!(body)

    t = Tropo::Generator.new
    t.say(:value => @manager.message)
    render :json => t.response
  end
end
