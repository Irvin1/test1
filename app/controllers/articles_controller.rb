class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
	
    respond_to do |format|
      format.html { redirect_to index_path }
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
	@comments = Comment.where(:articleid => params[:id])
	@comment = Comment.new(params[:comment])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new
	@categories = Category.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
	@categories = Category.all
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])
	@article.author = session[:user]
	@categories = Category.all
	
	if !params[:cat_ids]
		params[:cat_ids] = []
	end
	cats=[]
	params[:cat_ids].each do |cc|
		cats.push(Category.find(cc.to_i))
	end
	@article.categories = cats
	
    respond_to do |format|
      if @article.save && 
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])
	@categories = Category.all
	
	if !params[:cat_ids]
		params[:cat_ids] = []
	end
	cats=[]
	params[:cat_ids].each do |cc|
		cats.push(Category.find(cc.to_i))
	end
	@article.categories = cats
	
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to index_path }
      format.json { head :no_content }
    end
  end
end
