#!/usr/bin/env ruby
require "date"
require "optparse"

opt = OptionParser.new
params = {}
opt.on("-y [VAL]"){|v| v}
opt.on("-m [VAL]"){|v| v}
opt.parse!(ARGV, into: params)

selected_year = params[:y].to_i
selected_month = params[:m].to_i

if params[:y].nil?
  selected_year = Date.today.year
end
if params[:m].nil?
  selected_month = Date.today.month
end

last_day = Date.new(selected_year, selected_month, -1) 
first_day = Date.new(selected_year, selected_month, 1) 

puts "     #{selected_month}月 #{selected_year}"
puts "日 月 火 水 木 金 土"
print " " * first_day.wday * 3

(first_day..last_day).each do |x|
  print x.strftime("%e")," "
  puts if x.saturday?
end
puts
