# frozen_string_literal: true

require 'date'
require_relative '../app/date_helper.rb'

class DataParser
  def initialize(data)
    @data = data
  end

  # this constant can be moved to inside format as an argument for making dynamic.
  CITIES = {
    NYC: 'New York City',
    LA: 'Los Angeles'
  }.freeze

  def parse(sign = '$')
    @data = @data.split("\n").map { |item| item.split(sign).map(&:strip) }
    self
  end

  # for each column DateHelper tries to parse date. This can also be moved as an argumentt giving specific column
  # and based on that parse date.
  def format(column_order: ['first_name', 'city', 'birthdate'])
    header = @data.first

    positions = column_order.map { |item| header.index(item) }
    @data = @data.map do |item|
      positions.map do |position|
        if CITIES.keys.include?(item[position].to_sym)
          CITIES[item[position].to_sym]
        else
          DateHelper.parse_date(item[position]) || item[position]
        end
      end
    end
    self
  end

  # for first time we need header to not loose control with data
  def retrieve(with_header: false)
    return @data if with_header

    @data.drop(1)
  end

  private

  attr_reader :data
end
