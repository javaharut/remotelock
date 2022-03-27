# frozen_string_literal: true

# Can order any 2 dimensional array based on column name.
module ColumnOrderHelper
  def self.order(data, order_column)
    header = data.shift
    order_by_position = header.index(order_column)
    data.sort { |a, b| a[order_by_position] <=> b[order_by_position] }
  end
end
