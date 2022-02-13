require "test_helper"

class AuthenticationTest < ApplicationSystemTestCase
  setup do
    admin_user = FactoryBot.create(:user)
    # Ensure that an admin-level user has been created so that there are admins to receive
    #   user registration approval emails
    admin_user.add_role(:admin)
  end

  test 'sign up' do
    registration_data = {
      email: Faker::Internet.email,
      password: 'password'
    }

    visit new_user_registration_url

    fill_in 'Email', with: registration_data[:email]
    fill_in 'Password', with: registration_data[:password]
    fill_in 'Password confirmation', with: registration_data[:password]

    click_button('Sign up')

    assert page.has_selector?('.flash-container.flash-notice')
    assert page.has_selector?('.flash-message', text: I18n.t('devise.registrations.signed_up_but_not_approved'))
  end

  test 'login' do
    fake_user = FactoryBot.create(:user, password: 'password')

    visit user_session_url

    fill_in 'Email', with: fake_user.email
    fill_in 'Password', with: 'password'

    click_button('Log in')

    assert page.has_selector?('.flash-container.flash-notice')
    assert page.has_selector?('.flash-message', text: I18n.t('devise.sessions.signed_in'))
  end
end