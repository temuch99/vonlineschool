class StaticController < BaseController
  def main
  	@user = User.new
  end

  def contacts
  	@header[:main][:active] = false
  	@header[:contacts][:active] = true
  end

  private
  	def set_active_header_item
  		@header[:main][:active] = true
	end
end
