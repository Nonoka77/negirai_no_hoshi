require 'rails_helper'

RSpec.describe 'Profiles', type: :system do
  describe 'ユーザーの場合' do
    let(:user) { create(:user) }

    before do
      login(user)
      visit profiles_path(user)
    end

    xit '編集ボタンが表示される' do
      expect(page).to have_content('編集する')
    end

    it 'ゲストユーザーの情報が表示される' do
      expect(page).to have_content(user.username)
      expect(page).to have_content(user.email)
      expect(page).to have_content('あなたのメッセージ')
    end
  end

  describe 'ゲストユーザーの場合' do
    before do
      visit root_path
      click_on '今すぐ始める(ゲスト)'
      click_on 'マイページ'
    end

    xit '編集ボタンが表示されない' do
      expect(page).not_to have_content('編集する')
    end

    xit 'ゲストユーザーの情報が表示される' do
      expect(page).to have_content('guest')
      expect(page).to have_content('guest@example.com')
      expect(page).to have_content('あなたのメッセージ')
    end

    xit '編集ページへのアクセスに失敗する' do
      visit edit_profiles_path
      expect(page).to have_content('ゲストユーザーは編集できません。')
      expect(page).to have_current_path(root_path, ignore_query: true)
    end
  end
end
