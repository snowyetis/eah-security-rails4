namespace :fillProduct do
  desc 'Fill data'
  task data: :environment do

    Product.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('products')

    product = Product.new
    product.product_type = "locksmith",
    product.price = "420.50"

    product.save!

    product2 = Product.new
    product2.product_type = "cameras and security assessments",
    product2.price = "430.50"


    product2.save!

    product3 = Product.new
    product3.product_type = "certified fire door inspection",
    product3.price = "440.50"

      product3.save
  end
end
