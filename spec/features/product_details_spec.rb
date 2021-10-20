require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 69.69
      )
    end
  end

  scenario "They see all products" do
    # ACT
    visit root_path

    find_link('Details', :match => :first).click
    # DEBUG / VERIFY
    sleep 5
    save_screenshot
    puts page.html

    expect(page).to have_content 'Quantity' 
  end
end
