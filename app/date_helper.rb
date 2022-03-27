# frozen_string_literal: true

module DateHelper
  def self.parse_date(possible_date)
    date = Date.parse(possible_date)
    date.strftime('%-m/%-d/%Y')
  rescue StandardError
    nil
  end
end
