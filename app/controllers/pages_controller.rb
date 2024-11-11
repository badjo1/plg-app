class PagesController < ApplicationController
	allow_unauthenticated_access
	def home
	end

	def who_we_are
	end

	def what_we_do
	end

	def privacy
	end

	def calendar
		to_url = "https://lu.ma/playground.amsterdam"
		redirect_to to_url, allow_other_host: true 
	end

end
