class Customer
  attr_reader :id, :first_name, :last_name,
              :created_at, :updated_at

  def initialize(attrs, parent)
    @id = attrs[:id].to_i
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
    @created_at = format_time(attrs[:created_at])
    @updated_at = format_time(attrs[:updated_at])
  end

  def format_time(time_string)
    time_arr = time_string.split(/[-:' ']/)
    Time.utc(time_arr[0], time_arr[1], time_arr[2],
             time_arr[3], time_arr[4], time_arr[5])
  end
end
