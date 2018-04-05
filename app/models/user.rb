class User < ActiveRecord::Base
    has_many :projectusers
    has_many :potential_projects, ->{where(projectusers: {collaborator: true})}, through: :projectusers
    has_many :collab_projects, ->{ where(projectusers: {collaborator: true})}, through: :projectusers
	def self.find_or_create_from_auth_hash(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
          user.provider = auth.provider
          user.uid = auth.uid
          user.name = auth.info.first_name
          user.oauth_token = auth.credentials.token
          user.oauth_expires_at = Time.at(auth.credentials.expires_at)
          user.save!
		end
	end
end
