require 'rails_helper'

RSpec.describe Channel, type: :model do
  describe 'ActiveRecord associations' do
    it { is_expected.to have_many(:products).dependent(:destroy) }
    it { is_expected.to have_many(:products).with_foreign_key(:channel_id) }
    it { is_expected.to have_one(:setting).dependent(:destroy) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_db_index(:token).unique(true) }
    it { is_expected.to have_db_index(:products_successfully_fetched_at) }
    it { is_expected.to have_db_index(:products_successfully_pulled_at) }
    it { is_expected.to have_db_index(:user_id) }
    it { is_expected.to have_db_index(:token) }
  end

  describe 'scopes' do
    before do
      create(:channel, active: true)
      create(:channel, active: true)
      create(:channel, active: false)
    end

    it '.active returns all active channels' do
      expect(Channel.active.count).to eq(2)
    end
  end

  describe 'ActiveModel validations' do
    let!(:new_channel) { build(:channel)}

    it 'checks uniqueness of token' do
      expect(new_channel).to validate_uniqueness_of(:token).with_message('has already been taken')
    end
  end

  describe 'public instance methods' do
    describe '#deactivate!' do
      let!(:active_channel) { create(:channel, active: true) }

      it 'deactivates the channel' do
        expect { active_channel.deactivate! }.to change(active_channel, :active).to(false)
      end
    end

    describe '#inactive?' do
      let!(:inactive_channel) { create(:channel, active: false) }

      it { expect(inactive_channel).to be_inactive }
    end
  end
end
