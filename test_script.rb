#!/usr/bin/env ruby
require "pry"

def file(input, output)
  File.open(output, "w:utf-8") do |file|
    File.open(input).each do |line|
      parsed_line = line_parse(line)
      puts parsed_line
      file.write parsed_line
    end
  end
end

def line_parse(line, response="")
    # book name (word+ by itself but short, only comes at top of document) - don't worry about this
    # chapter number (digit+ by itself or word for chapter with digit+)
    return line if line["^\s+$"]

    if line.match(/^\s*(\p{digit}+)\s*$/)
      return response = line.gsub(/^\s*(\p{digit}+)\s*$/, "\n\\c \\1")
    end

    # headings (word+ by itself) - do not support because it could be a verse
    # if line.match(/^\s*(^\p{digit}+)\s*$/)
    #   return response = line.gsub(/^\s*(^\p{digit}+)\s*$/,"\n\\h \\1")
    # end

    # verse (digit+ word+ starts with digits or word+ by itself)
    if line[/(^\p{digit})/]
      return response = line
    end

    line.scan(/\p{digit}+.*\p{digit}*.+?/) do |verse|
      response << verse.gsub(/(\p{digit}+.*?\p{digit}*?)(.+)/, "\n\\v #{number_maker(\1)} \\2")
    end

    response
  end

  def number_maker(number_local)
      number_array = %w(۰ ۱ ۲ ۳ ۴ ۵ ۶ ۷ ۸ ۹)
      numbers_local = number_local.scan(/\p{digit}/) rescue binding.pry
      number = numbers_local.map{|n| number_array.index(n)}
  end

  def verse_parse(verse)
    "\\f #{verse}\n"
  end


  file("./file_folder/mzd_Luke.txt","./output.usfm")