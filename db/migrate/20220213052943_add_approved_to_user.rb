class AddApprovedToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :approved, :boolean, default: false, null: false
  end

  # Approve all current users that should be considered approved, so that they may still use their accounts
  # User.all.each{|user| user.approve}
end
