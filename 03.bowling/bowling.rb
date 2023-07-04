#!/usr/bin/env ruby
# frozen_string_literal: true

require 'debug'

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' # strike
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
point2 = 0
point3 = 0
frames.each_with_index do |frame, index|
  frame.slice!(1) if frame[0] == 10
  if index == 9 # 10フレーム
    if frame[0] == 10
      if frames[index + 1][0] == 10 # 2連続ストライク
        point1 += 20 + frames[index + 2][0]
        frame.push(frames[10][0], frames[11][0])
        frames.delete_at(-1)
      else # ストライク
        point1 += 10 + frames[index + 1].sum
        frame.push(frames[10][0], frames[10][1])
      end
      frames.delete_at(-1)
    elsif frame[0] + frame[1] == 10 # スペア
      point1 += 10 + frames[index + 1][0]
      frame.push(frames[10][0])
      frames.delete_at(-1)
    else
      point1 += frame.sum
    end
  end

  if index == 8 # 9フレーム
    point2 += if frame[0] == 10
                if frames[index + 1][0] == 10 # 2連続ストライク
                  20 + frames[index + 2][0]
                else # ストライク
                  10 + frames[index + 1].sum
                end
              elsif frame[0] + frame[1] == 10 # スペア
                10 + frames[index + 1][0]
              else
                frame.sum
              end
  end

  next unless index <= 7

  point3 += if frame[0] == 10
              if frames[index + 1][0] == 10 # 2連続ストライク
                20 + frames[index + 2][0]
              else # ストライク
                10 + frames[index + 1].sum
              end
            elsif frame.sum == 10 # スペア
              frames[index + 1][0] + 10
            else
              frame.sum
            end
end

p frames
puts point1 + point2 + point3
