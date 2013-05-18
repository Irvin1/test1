class MainnewsController < ApplicationController
  def index
	@articles=Article.all
  end
  
end
