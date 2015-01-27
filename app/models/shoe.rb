class Shoe < ActiveRecord::Base
  # attr_accessible :ShoeID, :OwnerID, :T2RS_ID, :Brand, :Style, :Material, :Size, :SizeType, :LengthFit, :RealSize
  self.primary_key = :ShoeID

  

  def Shoe.sizeToPreSize(size, sizeType, lengthFit)
  	Shoe.connection.execute(%[SELECT sizeToPreSize(#{size}, "#{sizeType}", "#{lengthFit}");]).to_a[0][0]
  end
end
