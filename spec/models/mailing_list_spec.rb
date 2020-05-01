# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MailingList, type: :model do
  it_should_behave_like NameTitleSlug do
    let( :sluggish ) { create :mailing_list }
  end
end
