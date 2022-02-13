# frozen_string_literal: true

# Mailer for sending emails to admin users
class AdminMailer < ApplicationMailer
  # Sends email to all admin users indicating that a new user has registered and needs approval
  #
  # @param [String] email Email address of user that wants to register with site
  def new_user_waiting_for_approval(email)
    @email = email

    admin_emails = User.with_role(:admin).pluck(:email)
    raise 'No admins currently available to approve user' if admin_emails.empty?

    mail(to: admin_emails, subject: 'New user awaiting admin approval')
  end
end
