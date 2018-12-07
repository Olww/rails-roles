class BellaObject < ApplicationRecord
  enum conf_level: [:unclassified, :confidential, :secret, :top_secret]
  after_initialize :set_default_conf_level, :if => :new_record?

  def set_default_conf_level
    self.conf_level ||= :unclassified
  end

  def readable_by?(user)
    self.conf_level_before_type_cast <= user.role_before_type_cast
  end

  def writable_by?(user)
    self.conf_level_before_type_cast >= user.role_before_type_cast
  end
end
