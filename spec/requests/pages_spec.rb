require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /video" do
    it "returns http success" do
      get "/pages/video"
      expect(response).to have_http_status(:success)
    end
  end

end
