# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  approved               :boolean          default(FALSE), not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

# A basic User that clients may use to authenticate and manage resources
class User < ApplicationRecord
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :recipes
  has_many :ingredients
  has_many :posts

  after_create :assign_default_role
  after_create :send_admin_email, unless: :approved?

  # Determines if a user is allowed to be authenticated, if they pass existing Devise authentication logic as well as
  #   being approved by an admin user
  #
  # @return [Boolean]
  def active_for_authentication?
    super && approved?
  end

  # Sends appropriate message for if the user is inactive or not, based on if they are approved or not
  #
  # @return [String]
  def inactive_message
    approved? ? super : :not_approved
  end

  # Handles sending instructions for a user to reset their password, adding on functionality to the default to make the
  #   process aware of and able to handle approved users
  #
  # @return [User]
  def self.send_reset_password_instructions(attributes = {})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      # Add error for user not yet being approved if they attempt to reset before being approved, and do not allow
      #   them to reset their password before being approved
      recoverable.errors[:base] << I18n.t('devise.failure.not_approved')
    elsif recoverable.persisted?
      # Send instructions to reset password if user has been approved
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  # Sets a user as approved in the database
  def approve
    self.approved = true
    save
  end

  # Sets a user as unapproved in the database
  def unapprove
    self.approved = false
    save
  end

  private

  # Sets default authorization role for a newly created user, if they do not already have any roles
  def assign_default_role
    add_role(Role::DEFAULT) if roles.blank?
  end

  # Send an email to admin users indicating newly created user needs approval
  def send_admin_email
    AdminMailer.new_user_waiting_for_approval(email).deliver
  end
end
