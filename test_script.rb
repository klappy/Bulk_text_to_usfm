#!/usr/bin/env ruby

def file(input, output)
  File.open(output, "w:utf-8") do |file|
    File.open(input).each do |line|
      file.write line_parse(line)
    end
  end
end

def line_parse(line)
  verses = line.split /(?<number>(\p{digit}+))/
  verses.each do |verse|
      verse_parse(verse)
  end
end

def verse_parse(verse)
    "\\f number_here #{verse}"
end


file("./file_folder/John1.txt","./output.usfm")