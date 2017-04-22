namespace :fillProduct do
  desc 'Fill data'
  task data: :environment do

    product = Product.new
    product.product_type = "locksmith",
    product.price = "400.50"

    product.save!

    product = Product.new
    product.product_type = "security services",
    product.price = "400.50"


    product.save!

    product = Product.new
    product.product_type = "fire door inspection",
    product.price = "400.50"

      product.save
  end
end
