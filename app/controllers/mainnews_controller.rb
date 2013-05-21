class MainnewsController < ApplicationController
  def index
	@articles=Article.all
	@categories = Category.all
  end
  
  def filtered
	@categories = Category.all
	@articles = Category.find(params[:id]).articles
	
    respond_to do |format|
      format.html { render action: "index" }
      format.json { render json: @articles }
    end
  end
end
