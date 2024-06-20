require 'rails_helper'

RSpec.describe PasswordValidator do
  context 'valid password' do
    context 'with atleast 1 uppercase, 1 lowercase and a digit'
    context 'with sequential 3 repeating characters'
    context 'with 1 upcase, 1 downcase, a digit and a nonsequential 3 repeating characters'
  end

  context 'invalid password' do
    context 'when all are lowercase chars'
    context 'when all are uppercase chars'
    context 'when all are digits'
    context 'with no lowercase char'
    context 'with no uppercase char'
    context 'with no digit'
    context 'with sequential 3 repeating characters'
    context 'with sequential 3 repeating space characters'
  end
end
