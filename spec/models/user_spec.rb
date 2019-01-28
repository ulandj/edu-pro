RSpec.describe User, type: :model do
  describe 'ActiveRecord associations' do
    it { is_expected.to have_many(:channels).dependent(:destroy) }
    it { is_expected.to have_many(:channels).with_foreign_key(:user_id) }
    it { is_expected.to have_db_index(:email).unique(true) }
  end

  describe 'ActiveModel validations' do
    let!(:new_user) { FactoryBot.build(:user) }

    it 'checks uniqueness of email' do
      expect(new_user).to validate_uniqueness_of(:email).with_message('has already been taken')
    end
    it { is_expected.not_to allow_value('base@example').for(:email) }
    it { is_expected.not_to allow_value('blah').for(:email) }
    it { is_expected.to allow_value('some@example.com').for(:email) }
  end
end
