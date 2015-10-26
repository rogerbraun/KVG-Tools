require_relative "kvg2sexp.rb"
require "nokogiri"

if ENV['SOURCE']
  file = File.open(ENV['SOURCE']) { |f| Nokogiri::XML(f) }

  file.xpath("//kanji").each do |kanji|
    #id has format: "kvg:kanji_CODEPOINT-Kaisho"
    #codepoint is a hex number
    codepoint = ("0x" + kanji.attributes["id"].value.split("_")[1].split("-")[0]).hex
    strokes = kanji.xpath("g//path").map{|p| p.attributes["d"].value }
    c = SVG_Character.new(codepoint, strokes)
    print c.to_sexp + "\n"
  end
else
  puts "Usage: SOURCE=kanjivg-20130901.xml ruby sexp_all_kanji.rb"
end

