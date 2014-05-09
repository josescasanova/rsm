class Resume < ActiveRecord::Base
  belongs_to :user

  serialize :summary
  serialize :work_experience
  serialize :education
end
