class PagesController < ApplicationController
	allow_unauthenticated_access
	def home
	end

	def get_involved
	end

	def start_a_project
	end

	def explore
	end

	def communities
	end

	def live
	end

	def events
	end

	def stories
	end

	def who_we_are
	end

	def what_we_do
	end

	def vision
	end

	def privacy
	end

	def governance
	end

	def token
	end

	def members
	end

	def calendar
		to_url = "https://lu.ma/playground.amsterdam"
		redirect_to to_url, allow_other_host: true 
	end

	def crypto_art_friends
		to_url = "https://caf-expo.vercel.app"
		redirect_to to_url, allow_other_host: true 
	end

end
