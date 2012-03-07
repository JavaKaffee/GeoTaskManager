# encoding: utf-8
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def load
    name = params[:name]
    @user = User.find(:first, :conditions => [ "lower(name) = ?", name.downcase ])
    @contexts = Context.find_all_by_user_id(@user)
    
    redirect_to user_contexts_path(@user)
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @header = {"back" => root_path, "ajax" => true, "title" => "Registrieren"}
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_contexts_path(@user), notice: 'Nutzer erfolgreich registriert.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:user_id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
