require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They should add an item to the cart" do
    # ACT
    visit root_path
    first('.btn-primary').click

    # DEBUG / VERIFY
    sleep 1
    save_screenshot "add to cart test.png"

    # VERIFY
    expect(page).to have_text("My Cart (1)")
  end
end
