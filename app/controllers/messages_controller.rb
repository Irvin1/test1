class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
	@messages = Message.all
  senders = Message.where("receiver_name = ? ", session[:user]).uniq.pluck(:sender_name)
	receivers = Message.where("sender_name = ? ", session[:user]).uniq.pluck(:receiver_name)
	@threads = (senders + receivers).uniq
	@users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end


  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # POST /messages
  # POST /messages.json
  def create

  @message = Message.new(params[:message])
	
	@message.read = false
    respond_to do |format|
      if @message.save
        format.html { redirect_to inbox_path, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to inbox_path }
      format.json { head :no_content }
    end
  end
  
  def conversation
	user = session[:user]
	thread = params[:thread_name]
  @message = Message.new
  @messages = Message.where("sender_name = ? AND receiver_name = ? OR sender_name = ? AND receiver_name = ?", session[:user], params[:thread_name], params[:thread_name], session[:user]).reorder('created_at ASC')
  respond_to do |format|
    if User.find_by_name(thread)
      format.html 
      format.json { head :no_content }
    else
      format.html { redirect_to inbox_path }
      format.json { head :no_content }
    end
      
    end
  end
  
  def deletethread
	message = Message.where("sender_name = ? AND receiver_name = ? OR sender_name = ? AND receiver_name = ?", session[:user], params[:thread_name], params[:thread_name], session[:user])
	message.destroy_all
	respond_to do |format|
      format.html { redirect_to inbox_path }
      format.json { head :no_content }
    end
  end
end
