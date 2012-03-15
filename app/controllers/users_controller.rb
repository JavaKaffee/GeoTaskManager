# encoding: utf-8
class UsersController < ApplicationController
  
  # GET /users
  # GET /users.json
  def index
    # Diese Seite wird User-unabhängig
    @independent = true
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def load
    name = params[:name]
    # Finde den User per Namen (case-insensitive)
    @user = User.find(:first, :conditions => [ "lower(name) = ?", name.downcase ])
    @contexts = Context.find_all_by_user_id(@user)
    # Leite zum User weiter
    redirect_to user_contexts_path(@user)
  end

  # GET /users/new
  # GET /users/new.json
  def new
    # Diese Seite ist User-unabhängig
    @independent = true
    @action = "Registrieren"
    @header = {"back" => root_path, "ajax" => true, "title" => "Registrieren"}
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end
  
  # GET /users/1/edit
  def edit
    @action = "Speichern"
    @user = User.find(params[:id])
    @header = {"back" => user_contexts_path(@user), "ajax" => false, "title" => "Administration", "delete" => true}    
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
  
  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_contexts_path(@user), notice: 'User wurde aktualisiert.' }
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
    @user = User.find(params[:user_id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
