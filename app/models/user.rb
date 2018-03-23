class User < ActiveRecord::Base
  # Creation before
  before_validation :normalize_name, on: :create
  # and after steps
  after_create :send_admin_mail

  has_many :quotes
  has_many :quote_details, through: :quotes
  has_many :questionaires

  ROLES = %i[user guest banned]

  def roles=(roles)
    roles = [*roles].map { |r| r.to_sym }
    self.role_id = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((role_id.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def has_role?(role)
    roles.include?(role)
  end

  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  :email

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(self).deliver
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  private

    def normalize_name
      self.name = first_name.downcase.titleize + " " + last_name.downcase.titleize
    end

end
