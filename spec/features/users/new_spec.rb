require 'rails_helper'

RSpec.describe "users/new.html.erb", type: :feature do
  it 'fills out and successfully submits form and redirect to root' do
    visit '/sign_up'

    expect(page).to have_content('Sign up for Piazza')
    expect(page).to have_button('Sign up!')

    fill_in 'Name', with: 'Johnny'
    fill_in 'Email', with: 'johnstamos@example.com'
    fill_in 'Password', with: '123abcdef'

    click_button 'Sign up!'

    expect(page).to have_current_path('/')
  end

  it 'unsuccessfully creates a user due to email' do
    visit '/sign_up'

    fill_in 'Name', with: 'Johnny'
    fill_in 'Email', with: 'jonemail.com'
    fill_in 'Password', with: '123abcdef'

    click_button 'Sign up!'

    expect(page).to have_current_path('/sign_up')
  end

  it 'unsuccessfully creates a user due to password being too short' do
    visit '/sign_up'

    fill_in 'Name', with: 'Johnny'
    fill_in 'Email', with: 'johnny@email.com'
    fill_in 'Password', with: '123'

    expect(page).to have_current_path('/sign_up')
  end

  it 'show green flash message after successful user creation' do
    visit '/sign_up'

    fill_in 'Name', with: 'John'
    fill_in 'Email', with: 'johndoe@example.com'
    fill_in 'Password', with: 'password'

    click_button 'Sign up!'

    expect(page).to have_current_path(root_path)
    expect(html).to have_selector('div', class: 'notification is-success')
    expect(page).to have_content(I18n.t("users.create.welcome", name: 'John'))
  end
end
