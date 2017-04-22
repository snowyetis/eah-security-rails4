json.extract! product_detail, :id, :created_at, :updated_at
json.url product_detail_url(product_detail, format: :json)