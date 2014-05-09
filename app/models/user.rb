class User < ActiveRecord::Base
  validates_presence_of :name

  has_many :resumes

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.consumer_token = auth['credentials']['token']
      user.consumer_secret = auth['credentials']['secret']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
         user.location = auth['info']['location'] || ""
         user.image_url = auth['info']['image'] || ""
      end
    end
  end

end
