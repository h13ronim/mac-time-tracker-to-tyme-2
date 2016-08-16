require "./spec_helper"

describe Mtttt2::Converter do
  it "should works" do
    time_tracker_file = "spec/fixtures/TimeTrackerData.csv"
    converter = Mtttt2::Converter.new(time_tracker_file)
    converter.output.should eq(
      "type;date;unix_start;unix_end;day;start;end;category;project;task;subtask;amount;amount_decimal;rate;sum;rounding_minutes;rounding_method;note
timed;06/06/16;1465197667;1465226947;Monday;09:21;17:29;;Foo;Bar;;08:08;8.13;;;1;NEAREST;
")
  end
end
