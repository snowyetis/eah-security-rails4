namespace :fillProduct do
  desc 'Fill data'
  task data: :environment do

    Product.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('products')

    product = Product.new
    product.product_type = "locksmith",
    product.price = "400.50"

    product.save!

    product = Product.new
    product.product_type = "cameras and security assessments",
    product.price = "400.50"


    product.save!

    product = Product.new
    product.product_type = "certified fire door inspection",
    product.price = "400.50"

      product.save
  end
end
