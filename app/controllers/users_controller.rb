class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all
	
	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
	@user = User.find(params[:id])
	@articleEntries = Article.where(:author => @user.name)
	userComments = Comment.where(:username => @user.name).pluck(:articleid)
	@commentedArticles = Article.find(userComments)
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
	    session[:user] = params[:user][:name]
        format.html { redirect_to index_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
	@articles = Article.where(:author => @user.name)
	@comments = Comment.where(:username => @user.name)
    respond_to do |format|
      if @user.update_attributes(params[:user])
		@articles.each do |aa|
			aa.author=params[:user][:name]
			aa.save
		end
		@comments.each do |cc|
			cc.username=params[:user][:name]
			cc.save
		end
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
	if @user.name == session[:name]	
		reset_session
	end
	adminCount = User.count(:conditions => ["admin = ?", true])
	if @user.admin && adminCount == 1
		flash[:notice] = "Can't delete last admin"
	else
		@user.destroy	
	end

    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end
  
  def admin
		format.html { redirect_to memebers_url }
		format.json { head :no_content }

  end
  
  def current
	if session[:user]
		@user=User.find_by_name(session[:user])
		@articleEntries = Article.where(:author => @user.name)
		userComments = Comment.where(:username => @user.name).pluck(:articleid)
		@commentedArticles = Article.find(userComments)
	end
	
	respond_to do |format|
      format.html # current.html.erb
      format.json { render json: @user }
    end
  end
  
  def makeadmin
	if session[:admin]

		@user=User.find(params[:format])
		adminCount = User.count(:conditions => ["admin = ?", true])
		if @user.admin && adminCount == 1
			flash[:notice] = "Can't change last admin"
		else
			@user.toggle!(:admin)	
		end
			redirect_to members_url
	end
  end
  
end
