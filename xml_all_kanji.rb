require_relative "kvg2sexp.rb"
require "nokogiri"

if ENV['SOURCE']
  file = File.open(ENV['SOURCE']) { |f| Nokogiri::XML(f) }

  #create directory csv
  Dir.mkdir("xml") unless File.directory?("xml")

  file.xpath("//kanji").each do |kanji|
    #id has format: "kvg:kanji_CODEPOINT-Kaisho"
    #codepoint is a hex number
    codepoint = ("0x" + kanji.attributes["id"].value.split("_")[1].split("-")[0]).hex
    strokes = kanji.xpath("g//path").map{|p| p.attributes["d"].value }
    c = SVG_Character.new(codepoint, strokes)
    f = File.new("xml/" + codepoint.to_s + ".xml", "w")
    f.write(c.to_xml)
    f.close
  end
else
  puts "Usage: SOURCE=kanjivg-20130901.xml ruby xml_all_kanji.rb"
end
