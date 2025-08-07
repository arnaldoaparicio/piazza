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
end
