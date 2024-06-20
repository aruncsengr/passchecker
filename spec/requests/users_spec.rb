require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get users_url

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /import" do
    context 'with no file' do
      it "returns http status - 302" do
        post '/users/import'

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_url)
        expect(flash[:notice]).to eq 'No file added.'
      end
    end

    context 'with invalid file' do
      it "returns http status - 302" do
        post '/users/import', params: {
          file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/users.csv", 'pdf'),
        }

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_url)
        expect(flash[:notice]).to eq 'Only CSV files allowed.'
      end
    end

    context 'with valid file' do
      let(:csv_file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/users.csv", 'text/csv') }

      before do
        allow(ActionDispatch::Http::UploadedFile).to receive(:new).and_return(csv_file)
      end

      it "returns http status - success" do
        file = Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/users.csv", 'text/csv')
        expect_any_instance_of(CsvImportUsersService).to receive(:call).once.with(csv_file)
        post '/users/import', params: { file: csv_file }

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(flash[:notice]).to eq 'Import processed.'
      end
    end
  end
end
