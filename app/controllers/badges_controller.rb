class BadgesController < ApplicationController

  def index
    @badges = []
    Badge.TOKENS.each do |token|
      if @badges.detect{|b| b.token == token}.nil?
        badge = Badge.new(:token => token)
        @badges << badge
      end
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @badges }
    end
  end

  # GET /badges/1
  # GET /badges/1.xml
  def show
    @badge = Badge.new(:token => params[:id])     
    @users = @badge.users(current_node)

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @badge.to_json }
    end
  end
  
end