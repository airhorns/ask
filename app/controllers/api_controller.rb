class ApiController < ApplicationController
  before_filter :authenticate_customer!
  respond_to :json
end
