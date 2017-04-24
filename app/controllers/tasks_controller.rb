class TasksController < ApplicationController
  def list
    task_entities = Task.all
    @tasks = Array.new
    authorize! :list, @tasks


    task_entities.each do |task_entity|
      @tasks << enrich(task_entity)
    end
  end
  def show
    task_entity = Task.find(params[:id])
    @task = enrich(task_entity)
    authorize! :list, @task
    @task['cycles'] = task_entity.cycles
  end

  def enrich(task_entity)
    task_hash = Hash.new

    task_hash['id'] = task_entity.id
    task_hash['created_at'] = task_entity.created_at
    task_hash['fails_count'] = task_entity.fails_count
    task_hash['cycles_count'] = task_entity.cycles.length

    total_fails_count = 0
    max_execution_time = 0
    average_execution_time = 0

    task_entity.cycles.each do |cycle|
      if !cycle.success
        total_fails_count = total_fails_count + 1
      end

      if max_execution_time.nil? || max_execution_time < cycle.execution_time
        max_execution_time = cycle.execution_time
      end

      average_execution_time = cycle.execution_time / task_entity.cycles.length
    end

    task_hash['total_fails_count'] = total_fails_count
    task_hash['max_execution_time'] = max_execution_time
    task_hash['average_execution_time'] = average_execution_time
    task_hash['order_id'] = task_entity.orders[0].id
    task_hash['order_status'] = task_entity.orders[0].status
    task_hash['order'] = task_entity.orders[0]

    task_hash
  end
end
