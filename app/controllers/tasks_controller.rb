# encoding: utf-8
class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
#  def index
#    @user = User.find(params[:user_id])
#    @tasks = Task.find_all_by_context_id(params[:context_id])
#    @context = Context.find(params[:context_id])
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @tasks }
#    end
#  end
  
  # GET /tasks/today
  # GET /tasks/today.json
  def today
    @user = User.find(params[:user_id])
    @tasks = Task.all.find_all { |task| task.expiration.today? && task.expiration >= DateTime.now && task.context.user_id == @user.id }
    @index = 1
    
    respond_to do |format|
      format.html # today.html.erb
      format.json { render json: @today }
    end
    
  end
  
  # GET /tasks/week
  # GET /tasks/week.json
  def week
    @user = User.find(params[:user_id])
    @tasks = Task.all.find_all { |task| task.expiration >= DateTime.now && task.expiration <= 7.days.from_now.to_datetime && task.context.user_id == @user.id }
    @index = 2
    
    respond_to do |format|
      format.html # week.html.erb
      format.json { render json: @week }
    end
  end
  
  # GET /tasks/overdue
  # GET /tasks/overdue.json
  def overdue
    @user = User.find(params[:user_id])
    @tasks = Task.all.find_all { |task| task.expiration <= DateTime.now && task.context.user_id == @user.id }
    @index = 3
    
    respond_to do |format|
      format.html # overdue.html.erb
      format.json { render json: @overdue }
    end
  end

  # GET /tasks/important
  # GET /tasks/important.json
  def important
    @user = User.find(params[:user_id])
    @tasks = Task.all.find_all { |task| task.important? && task.context.user_id == @user.id }
    @index = 4
    
    respond_to do |format|
      format.html # important.html.erb
      format.json { render json: @important }
    end
  end
  
  # GET /tasks/1
  # GET /tasks/1.json
#  def show
#    @user = User.find(params[:user_id])
#    @task = Task.find(params[:id])
#    @context = @task.context
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @task }
#    end
#  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @user = User.find(params[:user_id])
    @task = Task.new
    @context = Context.find(params[:context_id])
    @header = {"back" => user_context_path(@user,@context), "ajax" => true, "title" => "Task erstellen", "delete" => false}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
    @context = @task.context
    @header = {"back" => user_context_path(@user,@context), "ajax" => true, "title" => @task.name, "delete" => false}
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @user = User.find(params[:user_id])
    @task = Task.new(params[:task])
    @context = Context.find(params[:context_id])

    respond_to do |format|
      if @task.save
        format.html { redirect_to user_context_path(@user,@context), notice: 'Task wurde erstellt.' }
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
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
    @context = @task.context

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to user_context_path(@user,@context), notice: 'Task geändert.' }
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
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
    @context = @task.context
    @task.destroy

    respond_to do |format|
      format.html { redirect_to user_context_path(@user,@context) }
      format.json { head :no_content }
    end
  end
end
