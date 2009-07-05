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

s = Stroke.new("M10.25,33.29c0.37,0.51,0.76,0.94,0.92,1.58c1.29,5.07,3.34,18.54,4.23,27.63")

c = SVG_Character.new("吁 M10.25,33.29c0.37,0.51,0.76,0.94,0.92,1.58c1.29,5.07,3.34,18.54,4.23,27.63;M11.58,35.22c6.92-1.22,17.55-2.56,21.92-3.23c1.6-0.24,2.56,1.44,2.33,2.87,c-0.95,5.92-3.05,14.07-4.46,22.25;M15.07,59.05c5.14-0.75,11.33-1.05,18.39-2.21;[,M45.16,22.49c0.98,0.48,2.75,0.55,3.74,0.48c6.6-0.47,28.89-4.77,38.17-4.77c1.63,0,2.61,0.23,3.42,0.47;M40.27,49.86c1.44,0.56,4.09,0.7,5.53,0.56c10.65-1.05,32.31-3.88,47.88-3.82,c2.4,0.01,3.84,0.27,5.05,0.55;M67.25,23.66c0.74,0.88,1.69,2.87,1.69,5.79c0,12.8-0.72,58.43-0.72,63.2c0,10.09-7.63,0.19-8.61-0.71;")


print c.to_sexp


#draw_to_context(cr,c.to_points)


#cr.target.write_to_png("test.png")
