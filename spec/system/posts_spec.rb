require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { create :user }

  describe 'メッセージを送信' do
    before { login(user) }

    context '1文字以上入力した場合' do
      it '正常に送信される' do
        visit posts_path
        fill_in 'post_content', with: 'content'
        click_on '送信'
        expect(page).to have_content('content')
      end
    end

    context '空文字でメッセージ入力された場合' do
      it 'メッセージは送信されない' do
        visit posts_path
        fill_in 'post_content', with: ' '
        click_on '送信'
        expect(page).not_to have_content(' ')
      end
    end
  end

  describe 'ユーザー場合' do
    let!(:post) { create(:post, user: user) }

    before do
      login(user)
      visit posts_path
    end

    context 'メッセージを編集する場合' do
      it '編集内容が更新される' do
        find('.fa-edit').click
        find('.edit-textarea').set('edit content')
        click_on '更新'
        expect(page).to have_content('edit content')
      end
    end

    context 'メッセージを削除する場合' do
      it '削除に成功する' do
        find('.fa-trash-alt').click
        expect(page).not_to have_content('content')
      end
    end
  end
end
