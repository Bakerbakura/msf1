class CustomersController < ApplicationController
	
	before_filter :authenticate_customer, 
		:only => [:home, :addshoe, :delshoe, :predict]
	before_filter :save_login_state, :only => [:new, :create]

	def new
	end

	def create
		@parms = params[:customer]
		@lessparms = @parms.reject{|k,v| k == "Email_confirmation"}
		puts @lessparms
		if @parms["Email"] == @parms["Email_confirmation"]
			@customer = Customer.new(@lessparms)
			@customer.save
			session[:CustID] = @customer.CustID
			session[:preferredSizeType] = Sizetype.
					find_by_SizeType(@customer.preferredSizeType)
			redirect_to home_path
		else
			redirect_to signup_path
		end
	end

	def home
		@shoes = Shoe.where({OwnerID: @customer.CustID}).to_a
	end

	def index
		@customers = Customer.all
	end

	def addshoe
		@parms = params[:newshoe]
		newShoe = Shoe.new(@parms)
		newPreSize = Shoe.sizeToPreSize(@parms[:Size], @parms[:SizeType], @parms[:LengthFit])
		if (not @customer.ShoeSize) or (newPreSize - @customer.ShoeSize).abs <= 30.0
			newShoe.save
			Customer.updateShoeStats(@customer.CustID)
		else
			flash[:warning] = "You entered a new shoe with a size very different to your previous average shoe size. Please check the size of your new shoe or that of the shoes you have already entered."
		end

		redirect_to home_path
	end

	def delshoe
		@parms = params[:delshoe]
		Shoe.find_by_ShoeID(@parms[:ShoeID]).destroy
		Customer.updateShoeStats(@customer.CustID)

		redirect_to home_path
	end

	def predict
		@parms = params[:predic]
		Customer.establish_connection
		results = Customer.predictSizeToBuy(@parms[:CustID], @parms[:Brand], @parms[:Style], @parms[:Material], @parms[:SizeType])
		@parms["prediction"] = results[0]
		@parms["error"] = results[1]
	end
end