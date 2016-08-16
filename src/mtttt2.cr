require "./mtttt2/*"

module Mtttt2
end

Mtttt2::Converter.new(ARGV[0], ARGV[1]) if ARGV.size == 2
