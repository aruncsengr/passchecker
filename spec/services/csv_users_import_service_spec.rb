require 'rails_helper'

RSpec.describe CsvImportUsersService do
  let(:csv_file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/users.csv", 'text/csv') }

  describe '#call' do
    subject { described_class.new.call(csv_file) }

    it 'should return all users' do
      expect(subject.count).to be 5
      expect(subject).to all(be_an(User))
    end

    it 'should save valid users' do
      expect {
        subject
      }.to change(User, :count).from(0).to(1)
    end
  end
end
