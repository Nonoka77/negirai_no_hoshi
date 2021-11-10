module LoginModule
  def login(user)
    visit login_path
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: 'password'
    click_on('ログイン')
  end
end
