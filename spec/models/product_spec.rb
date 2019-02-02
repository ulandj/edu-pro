RSpec.describe Product, type: :model do
  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:channel) }
    it { is_expected.to have_db_index(:channel_id) }
    it { is_expected.to have_db_index(:images) }
    it { is_expected.to have_db_index(:options) }
    it { is_expected.to have_db_index(:variants) }
  end

  describe 'ActiveModel validations' do
    let!(:channel) { create(:channel) }
    let!(:new_product) { create(:product, channel: channel) }

    it 'checks uniqueness of remote_id in scope of channel' do
      expect(new_product).to validate_uniqueness_of(:remote_id).scoped_to(:channel_id).case_insensitive
    end
  end
end
