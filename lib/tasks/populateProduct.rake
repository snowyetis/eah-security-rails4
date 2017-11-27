namespace :fillProduct do
  desc 'Fill data'
  task data: :environment do

    product = Product.new
    product.product_type = "locksmith",
    product.price = "400.50"

    product.save!

    product2 = Product.new
    product2.product_type = "cameras and security assessments",
    product2.price = "400.50"


    product2.save!

    product3 = Product.new
    product3.product_type = "certified fire door inspection",
    product3.price = "400.50"

    product3.save!
  end
end
