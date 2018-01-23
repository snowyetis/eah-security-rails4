class Admin < ActiveRecord::Base
  has_many :products

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    ROLES = %i[admin]

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

    def admin?
      self.admin == true
    end

  end
