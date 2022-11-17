class RemoveUniqeConstraintFromApplications < ActiveRecord::Migration[5.0]
  def change
    remove_index :applications, name: "index_applications_on_token"
  end
end
