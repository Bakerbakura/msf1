class Customer < ActiveRecord::Base
  has_secure_password
  # attr_accessible :CustID, :Email, :Email_confirmation, :Gender, :ShoeSize, :ShoeSizeError, :password, :password_confirmation, :preferredSizeType
  self.primary_key = :CustID
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates_presence_of :Email, :Gender, :password, :preferredSizeType
  # validates_presence_of :password_confirmation
  # validates_presence_of :Email_confirmation
  validates_format_of :Email, with: EMAIL_REGEX, on: :create
  validates_length_of :Email, maximum: 30, message: "Email address should have length less than 30 characters"
  validates_length_of :password, minimum: 8, message: "Password should contain at least 8 characters"
  validates_inclusion_of :Gender, in: ["M","F"]
  validates_inclusion_of :preferredSizeType, in: Sizetype.all

  def Customer.updateShoeStats custid
  	Customer.connection.execute("CALL updateUserShoeStats(#{custid})")
  end

  def Customer.predictSizeToBuy(custid, brand, style, material, sizeType)
    Customer.connection.execute("CALL predictSizeToBuy(#{custid}, '#{brand}', '#{style}', '#{material}', '#{sizeType}')").to_a[0]
  end
end