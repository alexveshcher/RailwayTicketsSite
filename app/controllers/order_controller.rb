# require_relative '../../lib/services/converter/order_condition_converter.rb'
# require_relative '../../lib/services/manager/tickets_manager.rb'
require "date"

class OrderController < ApplicationController
  def new
	  @order = Order.new
    @condition_groups = ConditionGroup.all
    authorize! :new, @order
  end

  def create

	  @order = Order.new(order_params)
    authorize! :create, @order

    task = Task.new("fails_count" => 0)
    task.save

    @order.user_id = current_user.id
    @order.status = 'Open'
    @order.task_id = task.id

    @condition_groups = ConditionGroup.all

	  if @order.save
      order_condition_params.each do |order_condition|
        order_condition.order_id = @order.id
        order_condition.save
      end

      order_condition_converter = OrderConditionConverter.new
      hash_order = order_condition_converter.convert(@order.order_conditions)

      tickets_manager = TicketsManager.new

      res = tickets_manager.find_acceptable_tickets(@order.from_city_id, @order.to_city_id, @order.from_date.strftime("%d.%m.%Y"), hash_order)
      if !res[:data].empty?
        @tickets = res
        @order.update_attribute :status, 'Completed'
        render 'instant'
        return
      end
      


      scheduler = Rufus::Scheduler.new
      scheduler.every '30s', :first_in => 0.1 do |job|
        start = Time.now

        begin
          status = Order.find(@order.id).status
          fails_count = Task.find(task.id).fails_count


          if @order.expired?
            @order.update_attribute :status, 'Expired'
            job.unschedule

          # Catch "bad" orders
          elsif fails_count > 5
            @order.update_attribute :status, 'Failed'
            job.unschedule

          # Catch only open orders
          elsif(status == 'Open')
            task.update_attribute :fails_count, 0

            res = tickets_manager.find_acceptable_tickets(@order.from_city_id, @order.to_city_id, @order.from_date.strftime("%d.%m.%Y"), hash_order)
            puts res.size
            puts "RES:  #{res}"
            if(!res[:data].empty?)
              UserMailer.tickets_email(current_user.email ,res).deliver_now
              @order.update_attribute :status, 'Completed'

              puts 'Order completed and no longer tracked'
              job.unschedule

              finish = Time.now
              execution = finish - start

              cycle = Cycle.new({"execution_time" => execution, "success" => true, "task_id" => task.id, "service_message" => res.to_s})
              cycle.save
            end

          # Catch cancelled orders
          else
            puts 'Order is no longer open'
            job.unschedule
          end
        rescue Exception => e
          finish = Time.now
          execution = finish - start

          new_fails_count = fails_count + 1
          task.update_attribute :fails_count, new_fails_count

          cycle = Cycle.new({"execution_time" => execution, "success" => false, "task_id" => task.id, "error_message" => e.message})
          cycle.save
        end
      end

      redirect_to :action => 'list'
	  else
      error_msg = ''
      @order.errors.full_messages.each do |msg|
        error_msg += msg + "\n"
      end
      flash.now[:alert] = error_msg
      render action: "new"
	  end
  end

  def order_params
	  params.require(:orders).permit(:from_city_id, :to_city_id, :from_date, :from_city_name, :to_city_name)
  end

  def order_condition_params
    result = Array.new
    enabled_condition_groups = params['on']

    if enabled_condition_groups.nil?
      return result;
    end

    enabled_condition_groups.each do |condition_group|
        order_conditions_hash = params[condition_group]

        order_conditions_hash.each do |id, values|
          current_order_condition = Condition.find(id)

          if current_order_condition.value_type == 'C'
            values.each do |value|
              check_condition_param = ConditionParam.find(value)

              if check_condition_param.condition_id == number_or_nil(id)
                order_condition = OrderCondition.new({'condition_param_id' => value, 'condition_id' => id})
                result << order_condition
              end
            end
          elsif current_order_condition.value_type == 'S'
            if !values.nil?
              values.split(/, /).each do |value|
                if !value.to_s.empty?
                  order_condition = OrderCondition.new({'string_value' => value, 'condition_id' => id})
                  result << order_condition
                end
              end
            end
          else
            if !values.nil?
              if !number_or_nil(values).nil?
                order_condition = OrderCondition.new({'number_value' => values, 'condition_id' => id})
                result << order_condition
              end
            end
          end
        end
    end

    result
  end

  def number_or_nil(string)
    Integer(string || '')
  rescue ArgumentError
    nil
  end

  def list
    if(current_user.role != 'admin')
      @user = User.find(current_user.id)
      @orders = @user.orders
    else
      @orders = Order.all
    end


  end

  def show
	  @order = Order.find(params[:id])
  end

  def cancel
    @order = Order.find(params[:id])
    @order.update_attribute :status, 'Cancelled'
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Order was successfully cancelled.' }
      format.json { head :no_content }
    end
  end

end
