class Registration < ActiveRecord::Base
  belongs_to :product
  has_one :card
  accepts_nested_attributes_for :card

  validates :full_name, :company, :email, :telephone, presence: true

  def payment_method
    if card.nil? then "paypal"; else "card"; end
  end

  serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: "josephd.carlson@gmail.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: product.price,
        item_name: product.product_type,
        item_number: product.id,
        quantity: '1',
        notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
