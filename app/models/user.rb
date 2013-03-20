class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email, :github_username
  attr_accessible :admin unless Rails.env.production?

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
         user.github_username = auth['info']['nickname'] || ""
      end
      user.admin = true unless Rails.env.production?
    end
  end

  def is_admin?
    admin
  end

end
