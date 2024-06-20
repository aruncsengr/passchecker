require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_db_column(:name) }
  it { should have_db_column(:password) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(10).is_at_most(16) }

    context 'when password with sequential 3 chars' do
      subject { build(:user, :with_sequential_3_chars) }

      it { should be_invalid }
    end

    context 'when password with non-sequential 3 chars' do
      subject { build(:user, :with_non_sequential_3_chars) }

      it { should be_valid }
    end
  end
end
