class UniPollController < ApplicationController

	before_action :authenticate_user!
	before_action :set_uni_poll, :only => [:vote]

	def new 

	end

	def create
		@poll = UniPoll.create(:name => params[:poll_name]);
		UniPollAdminMapping.create(:uni_poll_id => @poll.id, :admin_id => current_user.id)
		contestants = params[:contestant_name]
		contestants.each do |contestant|
			byebug
			@poll.uni_poll_competitor_mappings.create(:competitor_name => contestant)
		end
		return redirect_to '/user_home'
	end

	def vote
		if @uni_poll.poll_end
			return redirect_to 'user_home'
		else
			@contestants_mapping = @uni_poll.uni_poll_competitor_mappings
		end

	end

	def contribute
		voter_mapping = UniPollVoterMapping.where(:uni_poll_id => params[:uni_poll_id],:voter_id => current_user.id).first
		unless voter_mapping
			your_fav = params[:your_fav]
			byebug
			uni_poll_competitor_mapping = UniPollCompetitorMapping.where(:uni_poll_id => params[:uni_poll_id],:competitor_name => your_fav).first
			uni_poll_competitor_mapping.votes = uni_poll_competitor_mapping.votes + 1
			uni_poll_competitor_mapping.save
			UniPollVoterMapping.create(:uni_poll_id => params[:uni_poll_id],:voter_id => current_user.id)
			return redirect_to '/result'
		end
		return redirect_to '/user_home'	
	end

	def stop_poll

	end

	def result

	end

	private

	def set_uni_poll
		@uni_poll = UniPoll.find(params[:uni_poll_id])
	end

end
