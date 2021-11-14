# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@alazykitchen.com'
  layout 'mailer'
end
