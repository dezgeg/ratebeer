module ApplicationHelper
  def round_average(avg)
    number_with_precision avg, precision: 1
  end
end
