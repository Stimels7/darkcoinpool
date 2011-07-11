require 'spec_helper'

describe ApplicationController do

  it "should have a authenticate_or_request_with_http_basic method" do
    controller.should respond_to(:authenticate_or_request_with_http_basic)
  end
end
