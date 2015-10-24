require_relative "kvg2sexp.rb"
require "nokogiri"

if ENV['SOURCE']
  file = File.open(ENV['SOURCE']) { |f| Nokogiri::XML(f) }

  #create directory csv
  Dir.mkdir("csv") unless File.directory?("csv")

  file.xpath("//kanji").each do |kanji|
    #id has format: "kvg:kanji_CODEPOINT-Kaisho"
    #filename = CODEPOINT or CODEPOINT-Kaisho
    filename = kanji.attributes["id"].value.split("_")[1]
    strokes = kanji.xpath("g/path").map{|p| p.attributes["d"].value }

    #stroke in the format [[x1, y1], [x2, y2] ...]
    strokes = strokes.map{ |stroke| Stroke.new(stroke).to_a }
    csv = File.open("csv/" + filename + ".csv", "w")
    strokes.each_with_index do |stroke, index|
      stroke.each do |point|
        csv.puts "#{index + 1}," + point.join(",")
      end
    end
    csv.close

  end
else
  puts "Usage: SOURCE=kanjivg-20130901.xml ruby csv_all_kanji.rb"
end
