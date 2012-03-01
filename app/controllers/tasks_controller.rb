class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.find_all_by_context_id(params[:context_id])
    @context = Context.find(params[:context_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end
  
  # GET /tasks/today
  # GET /tasks/today.json
  def today
    @tasks = Task.all
    @today = @tasks.find_all { |task| task.expiration.today? }
    @index = 1
    
    respond_to do |format|
      format.html # today.html.erb
      format.json { render json: @today }
    end
    
  end
  
  # GET /tasks/week
  # GET /tasks/week.json
  def week
    @week = Task.all.find_all { |task| task.expiration >= DateTime.now && task.expiration <= 7.days.from_now.to_datetime }
    @index = 2
    
    respond_to do |format|
      format.html # week.html.erb
      format.json { render json: @week }
    end
  end
  
  # GET /tasks/overdue
  # GET /tasks/overdue.json
  def overdue
    @overdue = Task.all.find_all { |task| task.expiration <= DateTime.now }
    @index = 3
    
    respond_to do |format|
      format.html # overdue.html.erb
      format.json { render json: @overdue }
    end
  end

  # GET /tasks/important
  # GET /tasks/important.json
  def important
    @important = Task.all.find_all { |task| task.important? }
    @index = 4
    
    respond_to do |format|
      format.html # important.html.erb
      format.json { render json: @important }
    end
  end
  
  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    @context = @task.context

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
    @context = Context.find(params[:context_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @context = @task.context
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @context = Context.find(params[:context_id])

    respond_to do |format|
      if @task.save
        format.html { redirect_to context_path(@context), notice: 'Task was successfully created.' }
        format.json { render json: @context, status: :created, location: @context }
      else
        format.html { redirect_to action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])
    @context = @task.context

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to context_path(@context), notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @context = Context.find(@task.context_id)
    @task.destroy

    respond_to do |format|
      format.html { redirect_to context_path(@context) }
      format.json { head :no_content }
    end
  end
end
