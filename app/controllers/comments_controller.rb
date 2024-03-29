class CommentsController < ApplicationController
  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
	@comment.username=session[:user]
	@article = Article.find(params[:comment][:articleid])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @article, notice: 'Comment was successfully added.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
		#format.html { redirect_to @article, notice: 'Comment was not successfully added.' }
        format.html { render :template => "articles/show", :locals => { :@article => @article, :@comments => Comment.where(:articleid => params[:comment][:articleid])} }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
	@article = Article.find(@comment.articleid)
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @article , notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
	@article = Article.find(@comment.articleid)
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @article , notice: 'Comment was deleted.' }
      format.json { head :no_content }
    end
  end
end
