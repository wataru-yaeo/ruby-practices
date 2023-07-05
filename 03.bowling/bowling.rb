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

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point1 = 0
frames[0..8].each_with_index do |frame, index| # 1〜9フレーム
  frame.slice!(1) if frame[0] == 10
  point1 += if frame[0] == 10
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

point2 = 0 # 10フレーム
frames[9].pop if frames[9][0] == 10
if frames[9][0] == 10
  if frames[10][0] == 10 # 2連続ストライク
    point2 += 20 + frames[11][0]
    frames[9].push(frames[10][0], frames[11][0])
    frames.delete_at(-1)
  else # ストライク
    point2 += 10 + frames[10].sum
    frames[9].push(frames[10][0], frames[10][1])
  end
  frames.delete_at(-1)
elsif frames[9].sum == 10 # スペア
  point2 += 10 + frames[10][0]
  frames[9].push(frames[10][0])
  frames.delete_at(-1)
else
  point2 += frames[9].sum
end

puts point1 + point2
