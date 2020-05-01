# frozen_string_literal: true

# Store details of mailing list subscribers who aren't authenticated users
class EmailRecipient < ApplicationRecord
  include Email
  include Token

  validates :name, presence: true

  has_many :subscriptions, as: :subscriber, dependent: :destroy
  has_many :lists, through: :subscriptions

  # Email stats (powered by Ahoy)
  has_many :messages, as: :user, dependent: :nullify,
                      class_name: 'Ahoy::Message'
end
