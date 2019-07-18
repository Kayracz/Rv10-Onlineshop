class Contact < ApplicationRecord
  validates :name, :email, presence: true
  validates :message, presence: true
end


