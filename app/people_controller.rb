# frozen_string_literal: true
require_relative '../app/data_parser.rb'
require_relative '../app/column_order_helper.rb'

class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    data = DataParser.new(params[:dollar_format]).parse.format.retrieve(with_header: true) +
           DataParser.new(params[:percent_format]).parse('%').format.retrieve

    ordered_data = ColumnOrderHelper.order(data, params[:order].to_s)
    ordered_data.reduce([]) { |acc, current| acc << current.join(', ') }
  end

  private

  attr_reader :params
end
