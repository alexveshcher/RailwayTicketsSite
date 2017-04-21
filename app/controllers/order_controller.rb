class OrderController < ApplicationController
  def new
	  @order = Order.new
    @condition_groups = ConditionGroup.all
  end

  def create

	  @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.status = 'Open'


    # TODO create job here
    scheduler = Rufus::Scheduler.new
    scheduler.every '5s' do |job|
      status = Order.find(@order.id).status
      if(status == 'Open')
        puts @order.status
      else
        puts 'Order is no longer open'
        job.unschedule
      end
    end
    # @order.task_id = job_id

    # MonitorWorker.perform_in(10.seconds, @order)
    # @order.task_id = 5

    @condition_groups = ConditionGroup.all

	  if @order.save
      puts @order.id

      # order_condition_params.each do |order_condition|
      #   order_condition.order_id = @order.id
      #   order_condition.save
      # end

      redirect_to :action => 'list'
	  else
		  render :action => 'new'
	  end
  end

  def order_params
	  params.require(:orders).permit(:from_city_id, :to_city_id, :from_date, :to_date)
  end

  def order_condition_params
    result = Array.new
    enabled_condition_groups = params['on']

    enabled_condition_groups.each do |condition_group|
        #TODO add validation logic

        order_conditions_hash = params[condition_group]

        order_conditions_hash.each do |id, values|
          current_order_condition = Condition.find(id)
          puts values

          if current_order_condition.value_type == 'C'
            order_condition = OrderCondition.new({'condition_param_id' => values, 'condition_id' => id})
            result << order_condition
          elsif current_order_condition.value_type == 'S'
            order_condition = OrderCondition.new({'string_value' => values, 'condition_id' => id})
            result << order_condition
          else
            order_condition = OrderCondition.new({'number_value' => values, 'condition_id' => id})
            result << order_condition
          end

        end
    end

    puts result.length
    result
  end

  def list
	  @orders = Order.all
  end

  def show
	  @order = Order.find(params[:id])
  end

end
