#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' # ストライク
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a { |s| }

point = 0
frames[0..8].each_with_index do |frame, index| # 1〜9フレーム
  point += if frame[0] == 10
             if frames[index + 1][0] == 10 # 2連続ストライク
               20 + frames[index + 2][0]
             else # ストライク
               10 + frames[index + 1].sum
             end
           elsif frame.sum == 10 # スペア
             10 + frames[index + 1][0]
           else
             frame.sum
           end
end

point += frames[9..].flatten.sum

puts point
