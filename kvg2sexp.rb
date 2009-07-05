# kvg2sexp.rb
# Takes as first argument the kanjistrokes.txt file you can find in the tagaini
# jisho svn. If given a second argument, it outputs the training data in 
# S-expression format to the file specified there. If not, it just prints it.


#A Point
class Point
  
  attr_accessor :x, :y
  
  def initialize(x,y)
    @x,@y = x, y
  end
  
  def to_sexp
    return "( " + @x.to_s + " " + @y.to_s + " )";
  end
  
  #Basic point arithmetics
  def +(p2)
    return Point.new(@x + p2.x, @y + p2.y)
  end
  
  def -(p2)
    return Point.new(@x - p2.x, @y - p2.y)
  end      
  
end  


# SVG_M represents the moveto command. 
# SVG Syntax is:
# m x y
# It sets the current cursor to the point (x,y).
# As always, capitalization denotes absolute values.
# Takes a Point as argument.
# If given 2 Points, the second argument is treated as the current cursor.
class SVG_M
  
  def initialize(p1, p2 = Point.new(0,0))
    @p = p1 + p2;    
  end
  
  #As there is now real movement, no output is necessary
  def to_sexp
    return ""
  end
  
  def to_points
    return []
  end
  
  def current_cursor
    return @p
  end
  
end

# SVG_C represents the cubic Bézier curveto command. 
# Syntax is:
# c x1 y1 x2 y2 x y
# It sets the current cursor to the point (x,y).
# As always, capitalization denotes absolute values.
# Takes 4 Points as argument, the fourth being the current cursor
# If constructed using SVG_C.relative, the current cursor is added to every
# point.
class SVG_C

  def initialize(c1,c2,p,current_cursor)
    @c1,@c2,@p,@current_cursor = c1,c2,p,current_cursor
  end
  
  def SVG_C.relative(c1,c2,p,current_cursor)
    SVG_C.new(c1 + current_cursor, c2 + current_cursor, p + current_cursor, current_cursor)
  end
  
  # This implements the algorithm found here:
  # http://www.cubic.org/docs/bezier.htm
  # Takes 2 Points and a factor between 0 and 1
  def linear_interpolation(a,b,factor)
  
   xr = a.x + ((b.x - a.x) * factor)
   yr = a.y + ((b.y - a.y) * factor)
     
   return Point.new(xr,yr);
   
  end 
  
  def make_curvepoint(factor)
    ab = linear_interpolation(@current_cursor,@c1,factor)
    bc = linear_interpolation(@c1,@c2,factor)
    cd = linear_interpolation(@c2,@p,factor)
    
    abbc = linear_interpolation(ab,bc,factor)
    bccd = linear_interpolation(bc,cd,factor)
    return linear_interpolation(abbc,bccd,factor)    
  end    
  
  # This gives back an array of points on the curve. The argument given
  # denotes how many points are calculated
  def make_curvepoint_array(points)
    result = Array.new
    
    factor = points.to_f
    
    (0..points).each {|point|
      result.push(make_curvepoint(point/(factor.to_f)))
    }
    
    return result
  end
  
  
  # This calculates 20 points on a curve and puts them out as a string
  def to_sexp
    curve_array = make_curvepoint_array(20)
    
    # Why did they call "fold" inject? It's still fold.
    return curve_array.inject("") {|result, element|
        result + element.to_sexp
      }
  end
  
  def to_points
    return make_curvepoint_array(20)
  end
  
  def current_cursor
    @p
  end
  

end

# SVG_S represents the smooth curveto command. 
# Syntax is:
# s x2 y2 x y
# It sets the current cursor to the point (x,y).
# As always, capitalization denotes absolute values.
# Takes 3 Points as argument, the third being the current cursor
# If constructed using SVG_S.relative, the current cursor is added to every
# point.
class SVG_S < SVG_C       

  def initialize(c2, p, current_cursor)
    super(reflect(c2,current_cursor), c2, p, current_cursor)
  end
  
  def SVG_S.relative(c2, p, current_cursor)
    SVG_C.relative(reflect(c2,current_cursor), c2, p, current_cursor)
  end
  
  def reflect(p, mirror)
    return mirror + (mirror - p)
  end
  
end 


# Stroke represent one stroke, which is a series of SVG commands.
class Stroke

  def initialize(stroke_as_code)
    @command_list = parse(stroke_as_code) 
  end
  
  def to_sexp
    return "( " + @command_list.inject("") {|result,element| result + element.to_sexp} + ")"
  end
  
  def to_points
    return @command_list.map{|element| element.to_points}.flatten
  end
  
  def split_elements(line)
    # This is magic.
    return line.gsub("-",",-").gsub("c",",c,").gsub("C",",C,").gsub("M","M,").gsub("[","").gsub(";",",;,").gsub(",,",",").split(/,/);
  end
  
  def parse(stroke_as_code)
    elements = split_elements(stroke_as_code)
    print elements
    
    command_list = Array.new
    current_cursor = Point.new(0,0);
    
    while elements != [] do

      case elements.slice!(0)
        when "M"
          x,y = elements.slice!(0..1)
          m = SVG_M.new(Point.new(x.to_f,y.to_f))
          current_cursor = m.current_cursor
          command_list.push(m)
          
        when "C"
          x1,y1,x2,y1,x,y = elements.slice!(0..5)
          c = SVG_C.new(Point.new(x1.to_f,y1.to_f), Point.new(x2.to_f,y2.to_f), Point.new(x.to_f,y.to_f), current_cursor)
          current_cursor = c.current_cursor
          command_list.push(c)    
          
        when "c"
          x1,y1,x2,y2,x,y = elements.slice!(0..5)
          c = SVG_C.relative(Point.new(x1.to_f,y1.to_f), Point.new(x2.to_f,y2.to_f), Point.new(x.to_f,y.to_f), current_cursor)
          current_cursor = c.current_cursor      
          command_list.push(c)     
           
        when "s"
          x2,y2,x,y = elements.slice!(0..3)
          s = SVG_S.relative(Point.new(x2.to_f,y2.to_f), Point.new(x.to_f,y.to_f), current_cursor)
          current_cursor = s.current_cursor
          command_list.push(s)                
          
        when "S"        
          x2,y2,x,y = elements.slice!(0..3)
          s = SVG_S.relative(Point.new(x2.to_f,y2.to_f), Point.new(x.to_f,y.to_f), current_cursor)
          current_cursor = s.current_cursor
          command_list.push(s)  
              
        else 
          print "You should not be here\n"
      
      end
      
    end
    
    return command_list  
                         
  end

end

# SVG_Character represents a whole character. It takes one argument, which
# is a string of one line of kanjisstrokes.txt, or at least a line in that
# format.
# The format is like this:
# Strokes are split by a ;
# The first character is the kanji, followed by a whitespace
#   
class SVG_Character
    
  def initialize(line)
    # Splits the line into the kanji character, which is then put into 
    # @character and the rest of the line.
    @character,rest = line.split(" ");
    @strokes = split_strokes(rest).map {|stroke| Stroke.new(stroke)}
  end
    
  def split_strokes(line)
    return line.split(";")
  end
    
  

end 

  
  