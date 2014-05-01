class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_many :group_invites, dependent: :destroy

  validates :provider, :uid, presence: true

  def self.from_provider_and_uid(provider, uid)
    where(provider: provider, uid: uid).first_or_initialize.tap do |user|
      user.provider = provider
      user.uid = uid
      user.save!
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.birthday = auth.extra.raw_info.birthday
      user.gender = auth.extra.raw_info.gender
      user.location = auth.info.location
      user.available = !auth.extra.raw_info.significant_other.present?
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def profile_picture_large
    "https://graph.facebook.com/#{uid}/picture?width=300&height=300"
  end

  def available_text
    available? ? "Available" : "Unavailable"
  end
end
