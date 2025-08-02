class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :email,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { case_sensitive: false }
end
