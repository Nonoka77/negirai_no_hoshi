require 'rails_helper'

RSpec.describe 'Profiles', type: :system do
  describe 'ユーザーの場合' do
    let(:user) { create(:user) }

    before do
      login(user)
      visit profiles_path(user)
    end

    it '編集ボタンが表示される' do
      expect(page).to have_content('編集する')
    end

    it 'ユーザーの情報が表示される' do
      expect(page).to have_content(user.username)
      expect(page).to have_content(user.email)
      expect(page).to have_content('あなたのメッセージ')
    end
  end
end
