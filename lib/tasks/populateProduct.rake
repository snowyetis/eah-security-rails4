namespace :fillProduct do
  desc 'Fill data'
  task data: :environment do

    ProductDetail.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('product_details')

    Product.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('products')

    @product = Product.create!(product_type: "locksmith", price: "420.50")
    @product.product_details.create!(product_id: @product.id, product_detail_type: "DEPENDIBILITY", model_description: "Hardware Replacement")
    @product.product_details.create!(product_id: @product.id, product_detail_type: "CONTROL", model_description: "Access Control - Design - Repair")
    @product.product_details.create!(product_id: @product.id, product_detail_type: "ASSURANCE", model_description: "High Security Locks - Highend Services")
    @product.product_details.create!(product_id: @product.id, product_detail_type: "24/7 SUPPORT", model_description: "24/7 support")

    @product2 = Product.create!(product_type: "cameras and security assessments", price: "420.50")
    @product2.product_details.create!(product_id: @product.id, product_detail_type: "TOP BRANDS", model_description: "Security Systems")
    @product2.product_details.create!(product_id: @product.id, product_detail_type: "CUTTING EDGE TECHNOLOGY", model_description: "Camera Systems")
    @product2.product_details.create!(product_id: @product.id, product_detail_type: "24/7 SUPPORT", model_description: "24/7 support")

    @product3 = Product.create!(product_type: "certified fire door inspection", price: "420.50")
    @product3.product_details.create!(product_id: @product.id, product_detail_type: "DEPENDIBILITY", model_description: "Hardware Replacement")
    @product3.product_details.create!(product_id: @product.id, product_detail_type: "CONTROL", model_description: "Access Control - Design - Repair")
    @product3.product_details.create!(product_id: @product.id, product_detail_type: "ASSURANCE", model_description: "High Security Locks - Highend Services")
    @product3.product_details.create!(product_id: @product.id, product_detail_type: "24/7 SUPPORT", model_description: "24/7 support")


  end
end
