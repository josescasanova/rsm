class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :location, :current_status, :picture_url
      t.text :summary, :work_experience, :education
      t.integer :current_status_timestamp, :user_id

      t.timestamps
    end
  end
end
