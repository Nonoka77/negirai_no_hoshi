require 'rails_helper'

RSpec.describe "GuestUsers", type: :system do
    describe '新規登録ページ' do
        context '正しく入力された場合' do
            it '正常に登録される' do
                visit new_user_registration_path
                fill_in 'user_username', with: 'user'
                fill_in 'user_email', with: 'user@example.com'
                fill_in 'user_password', with: 'password'
                fill_in 'user_password_confirmation', with: 'password'
                click_on 'Sign up'
                expect(page).to have_content('アカウント登録が完了しました')
            end
        end

        context '無効なユーザー名が入力された場合' do
            let(:user) {create :user}

            it '登録済みのユーザー名は無効になる' do
                visit new_user_registration_path
                fill_in 'user_username', with: (user.username)
                fill_in 'user_email', with: 'user_2@example.com'
                fill_in 'user_password', with: 'password'
                fill_in 'user_password_confirmation', with: 'password'
                click_on 'Sign up'
                expect(page).to have_content('ユーザー名はすでに存在します')
            end

            it '空文字は無効になる' do
                visit new_user_registration_path
                fill_in 'user_username', with: ' '
                fill_in 'user_email', with: 'user_2@example.com'
                fill_in 'user_password', with: 'password'
                fill_in 'user_password_confirmation', with: 'password'
                click_on 'Sign up'
                expect(page).to have_content('ユーザー名を入力してください')
            end

            it '空欄は無効になる' do
                visit new_user_registration_path
                fill_in 'user_username', with: ''
                fill_in 'user_email', with: 'user_2@example.com'
                fill_in 'user_password', with: 'password'
                fill_in 'user_password_confirmation', with: 'password'
                click_on 'Sign up'
                expect(page).to have_content('ユーザー名を入力してください')
                expect(page).to have_content('ユーザー名は1文字以上で入力してください')
            end
        end

        context '無効なメールアドレスが入力された場合' do
            let(:user) {create :user}

            it '登録済みのメールアドレスは無効になる' do
                visit new_user_registration_path
                fill_in 'user_username', with: 'user'
                fill_in 'user_email', with: (user.email)
                fill_in 'user_password', with: 'password'
                fill_in 'user_password_confirmation', with: 'password'
                click_on 'Sign up'
                expect(page).to have_content('メールアドレスはすでに存在します')
            end

            it '空欄は無効になる' do
                visit new_user_registration_path
                fill_in 'user_username', with: 'user'
                fill_in 'user_email', with: ' '
                fill_in 'user_password', with: 'password'
                fill_in 'user_password_confirmation', with: 'password'
                click_on 'Sign up'
                expect(page).to have_content('メールアドレスを入力してください')
            end

            it '空文字は無効になる' do
                visit new_user_registration_path
                fill_in 'user_username', with: 'user'
                fill_in 'user_email', with: ' '
                fill_in 'user_password', with: 'password'
                fill_in 'user_password_confirmation', with: 'password'
                click_on 'Sign up'
                expect(page).to have_content('メールアドレスを入力してください')
            end
        end
    end

    describe 'ログインページ' do
        let(:user) {create :user}

        before {login(user)}

        it 'ログイン後の表示に切り替わっている' do
            expect(page).to have_content('早速ねぎらってもらう')
            expect(page).to have_content('ホーム')
            expect(page).to have_content('ねぎらう')
            expect(page).to have_content('マイページ')
        end
    end
end