require 'rails_helper'

RSpec.describe "Authentications", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/authentication/create"
      expect(response).to have_http_status(:success)
    end
  end

end
