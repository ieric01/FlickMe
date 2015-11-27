require "rails_helper"

RSpec.describe StaticPagesController, :type => :controller do
  describe 'GET #index' do
    context 'when visit site' do
      it 'renders index template' do
        get :index
        expect(response).to have_http_status(200)
        expect(response).to render_template("index")
      end
    end
  end
end
