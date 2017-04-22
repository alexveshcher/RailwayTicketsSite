# require_relative '../../lib/services/converter/order_condition_converter.rb'
# require_relative '../../lib/services/manager/tickets_manager.rb'

class OrderController < ApplicationController
  def new
	  @order = Order.new
    @condition_groups = ConditionGroup.all

    # current_order = Order.find(16)
    # order_condition_converter = OrderConditionConverter.new
    # hash_order = order_condition_converter.convert(current_order.order_conditions)
    # puts hash_order
    #
    # tickets_manager = TicketsManager.new
    # puts tickets_manager.find_acceptable_tickets(2218155, 2200001, '25.04.2017', hash_order)
  end

  def create

	  @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.status = 'Open'


    @condition_groups = ConditionGroup.all

	  if @order.save

      order_condition_params.each do |order_condition|
        order_condition.order_id = @order.id
        order_condition.save
      end

      order_condition_converter = OrderConditionConverter.new
      hash_order = order_condition_converter.convert(@order.order_conditions)
      # puts hash_order

      tickets_manager = TicketsManager.new

      # TODO create job here
      scheduler = Rufus::Scheduler.new
      scheduler.every '30s' do |job|
        status = Order.find(@order.id).status
        if(status == 'Open')
          # puts @order.status
          res = tickets_manager.find_acceptable_tickets(@order.from_city_id, @order.to_city_id, @order.from_date.strftime("%d.%m.%Y"), hash_order)
          puts res
          if(!res.empty?)
            UserMailer.welcome_email(res.to_s).deliver_now
            @order.update_attribute :status, 'Completed'
            puts 'Order completed and no longer tracked'

            job.unschedule

          end

        else
          puts 'Order is no longer open'
          job.unschedule
        end
      end

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
	  @orders = Order.all
  end

  def show
	  @order = Order.find(params[:id])
  end

end
