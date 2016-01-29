class User < ActiveRecord::Base
  has_secure_password

  def self.create_or_get_from_oauth(hash)
    existing = User.find_by(provider: hash[:provider], uid: hash[:uid])
    if existing
      return existing
    else
      u = User.new(provider: hash[:provider], uid: hash[:uid])
      u.password = SecureRandom.hex(32)
      u.email = hash[:info][:email]
      u.username = hash[:info][:name]
      u.save
      return u
    end
  end
end
