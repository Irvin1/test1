class SessionsController < ApplicationController
  def signin

  end
  
  def create
  email = params[:session][:email]
  
  user = User.find_by_email(email.downcase)
  if user && user.authenticate(params[:session][:password])
    session[:user] = user.name
	session[:admin] = user.admin
	respond_to do |format|
		format.html { redirect_to index_path}
		format.json { head :no_content }
	end
  else
	  respond_to do |format|
		format.html { flash[:notice] = 'Invalid login.' 
		redirect_to login_path  }
	  end
  end
	
  end
  
  def signout
	reset_session
	respond_to do |format|
		format.html { redirect_to index_path}
		format.json { head :no_content }
	end
  end
end
