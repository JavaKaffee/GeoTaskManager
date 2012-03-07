# encoding: utf-8
class ContextsController < ApplicationController
  # GET /contexts
  # GET /contexts.json
  def index
    @user = User.find(params[:user_id])
    @contexts = Context.find_all_by_user_id(@user.id)
    @index = 0

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contexts }
    end
  end

  # GET /contexts/1
  # GET /contexts/1.json
  def show
    @context = Context.find(params[:id])
    @user = User.find(params[:user_id])
    @tasks = Task.order("important DESC","expiration ASC").find_all_by_context_id(params[:id])
    @header = {"back" => user_contexts_path(@user), "ajax" => false, "title" => @context.name, "delete" => false}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @context }
    end
  end
  
  # GET /contexts/1
  # GET /contexts/1.json
  def here
    @user = User.find(params[:user_id])
    @lat = params[:latitude].to_s.to_f
    @long = params[:longitude].to_s.to_f
    lat_l = @lat-0.01380000
    lat_r = @lat+0.01380000
    long_l = @long-0.01680000
    long_r = @long+0.01680000

    @context = Context.find(:first, :conditions => { :user_id => @user, :latitude => lat_l..lat_r, :longitude => long_l..long_r })
      
    respond_to do |format|
      if @context.nil?
        format.html { redirect_to user_contexts_path(@user), notice: "Kein Kontext in der Nähe gefunden." }
        format.json { head :no_content }
      else
        @header = {"back" => user_contexts_path(@user), "ajax" => false, "title" => @context.name, "delete" => false}
        @tasks = Task.order("important DESC","expiration ASC").find_all_by_context_id(@context.id)
        format.html
        format.json { render json: @context }
      end
    end
  end

  # GET /contexts/new
  # GET /contexts/new.json
  def new
    @user = User.find(params[:user_id])
    @header = {"back" => user_contexts_path(@user), "ajax" => false, "title" => "Neuer Kontext", "delete" => false}
    @context = Context.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @context }
    end
  end

  # GET /contexts/1/edit
  def edit
    @user = User.find(params[:user_id])
    @context = Context.find(params[:id])
    @header = {"back" => user_contexts_path(@user), "ajax" => false, "title" => @context.name + " bearbeiten", "delete" => true}    
  end

  # POST /contexts
  # POST /contexts.json
  def create
    @user = User.find(params[:user_id])
    @context = Context.new(params[:context])

    respond_to do |format|
      if @context.save
        format.html { redirect_to user_contexts_path(@user), notice: 'Kontext erfolgreich erstellt.' }
        format.json { render json: @context, status: :created, location: @context }
      else
        format.html { render action: "new" }
        format.json { render json: @context.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contexts/1
  # PUT /contexts/1.json
  def update
    @user = User.find(params[:user_id])
    @context = Context.find(params[:id])

    respond_to do |format|
      if @context.update_attributes(params[:context])
        format.html { redirect_to user_contexts_path(@user), notice: 'Kontext wurde aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @context.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contexts/1
  # DELETE /contexts/1.json
  def destroy
    @user = User.find(params[:user_id])
    @context = Context.find(params[:id])
    @context.destroy

    respond_to do |format|
      format.html { redirect_to user_contexts_path(@user) }
      format.json { head :no_content }
    end
  end
end
