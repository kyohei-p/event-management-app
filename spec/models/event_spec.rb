require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'バリデーション' do
    let(:category) { create(:category) }
    let(:user) { create(:user) }
    let(:event) { build(:event, category: category, user: user) }

    context 'カテゴリーが入力された時' do
      it '有効' do
        expect(event).to be_valid
      end
    end

    context 'カテゴリー未入力の時' do
      it '無効' do
        event.category = nil
        event.valid?
        expect(event.errors[:category_id]).to include("カテゴリーを選択してください。")
      end
    end
  end
end