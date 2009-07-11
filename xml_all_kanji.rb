require "kvg2sexp.rb"

i = 0
IO.read("kanjisstrokes.txt").each do |line|
  if ! line["#"]
    c = SVG_Character.new(line)
    f = File.new("xml/" + i.to_s + ".xml", "w")
    f.write(c.to_xml)
    f.close
    i += 1    
  end  
end
