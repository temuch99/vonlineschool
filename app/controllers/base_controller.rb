class BaseController < ApplicationController
	include BaseHelper

	before_action :set_header, except: :destroy
	before_action :set_active_header_item, except: :destroy
end