require 'rails_helper'

RSpec.describe PasswordValidator do
  let(:error_message) do
    'Password must contain at least one lowercase character, '\
    'one uppercase character, one digit and cannot contain three repeating characters.'
  end

  before do
    stub_const("Validatable", Class.new).class_eval do
      include ActiveModel::Validations

      attr_accessor :password
      validates :password, password: true
    end
  end

  subject do
    model = Validatable.new
    model.password = password
    model
  end

  context 'valid password' do
    context 'with atleast 1 uppercase, 1 lowercase and a digit' do
      let(:password) { 'Aqpfk1swods' }

      it { should be_valid }
    end
    context 'with 1 upcase, 1 downcase, a digit and a nonsequential 3 repeating characters' do
      let(:password) { 'QPFJWz1343439' }

      it { should be_valid }
    end
  end

  context 'invalid password' do
    context 'with error message' do
      let(:password) { 'AAAfk1swods' }

      it 'shows error message' do
        subject.valid?
        expect(subject.errors.full_messages).to match_array(error_message)
      end
    end

    context 'when all are lowercase chars' do
      let(:password) { 'abcdefghijklm' }

      it { should be_invalid }
    end

    context 'when all are uppercase chars' do
      let(:password) { 'ABCDEFGHIJKLM' }

      it { should be_invalid }
    end

    context 'when all are digits' do
      let(:password) { '123456789012' }

      it { should be_invalid }
    end

    context 'with no lowercase char' do
      let(:password) { 'ABCDEFGHIJK12' }

      it { should be_invalid }
    end
    context 'with no uppercase char' do
      let(:password) { 'abcdefghijk12' }

      it { should be_invalid }
    end
    context 'with no digit' do
      let(:password) { 'AqpfkHswads' }

      it { should be_invalid }
    end
    context 'with sequential 3 repeating characters' do
      let(:password) { 'AAAfk1swods' }

      it { should be_invalid }
    end
    context 'with sequential 3 repeating space characters' do
      let(:password) { 'AAAfk1   ds' }

      it { should be_invalid }
    end
  end
end
