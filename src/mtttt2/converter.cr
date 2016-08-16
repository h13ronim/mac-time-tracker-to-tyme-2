require "csv"

module Mtttt2
  class Converter
    TYME2_HEADER = "type;date;unix_start;unix_end;day;start;end;category;project;task;subtask;amount;amount_decimal;rate;sum;rounding_minutes;rounding_method;note"

    def initialize(input_file, output_file = nil)
      return unless input_file
      @time_tracker_data = CSV.parse(File.read(input_file), separator: ';')
      save_to_file(output_file) if output_file
    end

    def save_to_file(output_file)
      File.write(output_file, output)
    end

    def output
      io = MemoryIO.new
      CSV.build(io) do |csv|
        csv.row(TYME2_HEADER)
        @time_tracker_data.each_with_index do |row, n|
          next if n == 0
          begin
            csv.row([
              "timed", # type
              Time.parse(row[2], "%F").to_s("%D"), # date
              Time.parse(row[3], "%F %T").to_s("%s"), # unix_start
              Time.parse(row[4], "%F %T").to_s("%s"), # unix_end
              Time.parse(row[2], "%F").to_s("%A"), # day
              Time.parse(row[3], "%F %T").to_s("%R"), # start
              Time.parse(row[4], "%F %T").to_s("%R"), # end
              "", # category
              row[0], # project
              row[1], # task
              "", # subtask
              Time.parse(row[5], "%T").to_s("%R"), # amount
              amount_decimal(Time.parse(row[5], "%T")), # amount_decimal
              "", # rate
              "", # sum
              "1", # rounding_minutes
              "NEAREST", # rounding_method
              ""
            ].join(";"))
          rescue e : Time::Format::Error
            puts "Skipped row: #{row.inspect}"
          end
        end
      end
      io.to_s
    end

    private def amount_decimal(duration)
      "#{duration.to_s("%H").to_i}.#{(100.0 / 60 * duration.to_s("%M").to_i).to_i}"
    end
  end
end
