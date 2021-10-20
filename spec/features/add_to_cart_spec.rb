require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "They add a product to their cart and see My Cart(0) changes to (1) " do
    # ACT
    visit root_path
      
    find('button', text: 'Add', :match => :first).click
    # DEBUG / VERIFY
    sleep 5
    save_screenshot
    puts page.html

    expect(page).to have_content 'My Cart (1)' 
  end
end
