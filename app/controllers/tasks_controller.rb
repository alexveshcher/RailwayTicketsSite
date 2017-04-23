class TasksController < ApplicationController
  def list
    @tasks = Task.all
  end
  def show
    @task = Task.find(params[:id])
  end
end
