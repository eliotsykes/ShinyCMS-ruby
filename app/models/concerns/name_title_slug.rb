# frozen_string_literal: true

# Common behaviour for names, titles, and slugs, for pages and page sections
module NameTitleSlug
  extend ActiveSupport::Concern

  # Allowed characters for slugs: a-z A-Z 0-9 . _ -
  SLUG_REGEX = %r{[-_\.a-zA-Z0-9]+}.freeze
  private_constant :SLUG_REGEX
  ANCHORED_SLUG_REGEX = %r{\A#{SLUG_REGEX}\z}.freeze
  private_constant :ANCHORED_SLUG_REGEX

  included do
    validates :name,  presence: true
    validates :title, presence: true
    validates :slug,  presence: true, format: ANCHORED_SLUG_REGEX

    if has_attribute?( :section_id )
      validates :slug, safe_slug: true
      validates :slug, uniqueness: {
        scope: :section,
        message: I18n.t( 'concerns.name_title_slug.slug_must_be_unique' )
      }
    else
      validates :slug, uniqueness: {
        message: I18n.t( 'concerns.name_title_slug.slug_must_be_unique' )
      }
    end

    before_validation :generate_title, if: -> { title.blank? && name.present? }
    before_validation :generate_slug,  if: -> { slug.blank?  && name.present? }

    def generate_title
      self.title = name.titlecase
    end

    def generate_slug
      self.slug = name.parameterize
    end
  end
end
