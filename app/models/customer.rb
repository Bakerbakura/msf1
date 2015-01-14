require "bcrypt"

class Customer < ActiveRecord::Base
  has_secure_password
  # attr_accessible :CustID, :Email, :Email_confirmation, :Gender, :ShoeSize, :ShoeSizeError, :password, :password_confirmation, :preferredSizeType
  self.primary_key = :CustID
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  def Customer.updateShoeStats custid
  	Customer.connection.execute("CALL updateUserShoeStats(#{custid})")
  end

  def Customer.predictSizeToBuy(custid, brand, style, material, sizeType)
    Customer.connection.execute("CALL predictSizeToBuy(#{custid}, '#{brand}', '#{style}', '#{material}', '#{sizeType}')").to_a[0]
  end
end