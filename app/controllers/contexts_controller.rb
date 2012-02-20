class ContextsController < ApplicationController
  # GET /contexts
  # GET /contexts.json
  def index
    @contexts = Context.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contexts }
    end
  end

  # GET /contexts/1
  # GET /contexts/1.json
  def show
    @context = Context.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @context }
    end
  end
  
  # GET /contexts/1
  # GET /contexts/1.json
  def here
    @contexts = Context.all
    @context = @contexts.first
    
    @contexts.each do |context|
      
    end

    respond_to do |format|
      format.html # here.html.erb
      format.json { render json: @context }
    end
  end

  # GET /contexts/new
  # GET /contexts/new.json
  def new
    @context = Context.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @context }
    end
  end

  # GET /contexts/1/edit
  def edit
    @context = Context.find(params[:id])
  end

  # POST /contexts
  # POST /contexts.json
  def create
    @context = Context.new(params[:context])

    respond_to do |format|
      if @context.save
        format.html { redirect_to @context, notice: 'Context was successfully created.' }
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
    @context = Context.find(params[:id])

    respond_to do |format|
      if @context.update_attributes(params[:context])
        format.html { redirect_to @context, notice: 'Context was successfully updated.' }
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
    @context = Context.find(params[:id])
    @context.destroy

    respond_to do |format|
      format.html { redirect_to contexts_url }
      format.json { head :no_content }
    end
  end
end
