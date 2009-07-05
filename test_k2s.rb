require 'cairo'
require "kvg2sexp.rb"

def draw_to_context(cr, points)

#cr.set_source_color(Cairo::Color.parse(:black))
#cr.set_line_width(0.1);
#cr.rectangle(10,10,2,2);
#cr.fill
  cr.set_source_color(Cairo::Color.parse(:black))
  cr.set_line_width(0.1);
  #cr.move_to(points[0].x,points[0].y)

  points.each do |point|
  
    cr.rectangle(point.x,point.y,2,2);
    cr.fill;
  
  end
  
end

surface = Cairo::ImageSurface.new(109,109)
cr = Cairo::Context.new(surface)
cr.set_source_color(Cairo::Color.parse(:white))
cr.paint
#cr.set_source_color(Cairo::Color.parse(:black))
#cr.set_line_width(0.1);
#cr.rectangle(10,10,2,2);
#cr.fill

p1 = Point.new(0,50)
p4 = Point.new(100,50)
p2 = Point.new(30,10)
p3 = Point.new(70,80)

curve = SVG_C.new(p2,p3,p4,p1)

draw_to_context(cr,curve.to_points)


cr.target.write_to_png("test.png")
