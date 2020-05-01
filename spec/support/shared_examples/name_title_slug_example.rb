# frozen_string_literal: true

# Shared test code, for testing methods mixed-in by the NameTitleSlug concern
RSpec.shared_examples NameTitleSlug do
  context 'trying to set a null slug' do
    it 'gets a slug set automagically' do
      sluggish.update!( name: 'Slug This!!', slug: nil )
      expect( sluggish.slug ).to eq 'slug-this'
    end
  end
end
