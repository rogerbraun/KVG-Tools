#!/usr/bin/ruby

class Bitmap
  def initialize (x, y)
    @xsize = x;
    @ysize = y;
    
  end  
  
  def set(x,y)
  end

end

# Eine Bezier-Kurve
class SVG_C

  def to_s
    return "Bezier-Kurve:\n" + @a.to_s + "\n" + @b.to_s + "\n" + @c.to_s + "\n" + @d.to_s + "\n"
  end  
  def SVG_C.relative(x0,y0,x1,y1,x2,y2,x3,y3,xadd,yadd)
    return SVG_C.new(x0,y0,x1+xadd,y1+yadd,x2+xadd,y2+yadd,x3+xadd,y3+yadd)
  end

  def initialize(x0,y0,x1,y1,x2,y2,x3,y3)
    @x0,@y0,@x1,@y1,@x2,@y2,@x3,@y3 = x0,y0,x1,y1,x2,y2,x3,y3;
    @a={};
    @b={};
    @c={};
    @d={};
    @a["x"]=x0;
    @a["y"]=y0;
    @b["x"]=x1;
    @b["y"]=y1;
    @c["x"]=x2;
    @c["y"]=y2;
    @d["x"]=x3;
    @d["y"]=y3;            
  end 
  
  def linear_interpolation(a,b,factor)
     if factor > 1
     print "Error: Factor > 1";
     end
     x0,y0,x1,y1=a["x"],a["y"],b["x"],b["y"];
     xr = x0 + ((x1 - x0) * factor)
     yr = y0 + ((y1 - y0) * factor)
     result= {};
     result["x"] = xr
     result["y"] = yr
     
     return result;
  end   
  
  def to_SEXP
    sexp = ""
    distance = Math.sqrt(((@x0 - @x3)**2) + ((@y0 - @y3)**2)).ceil
    make_curvepoint_array((distance/2)).each { |point|
      
      sexp += "(" + (point["x"].round.to_s) + " " + (point["y"].round.to_s) + ")";
    
    }    
    return sexp
  end 
   
  
  def make_curvepoint_array(points)
    result = Array.new
    
    factor = points.to_f
    
    (0..points).each {|point|
      result.push(make_curvepoint(point/(factor.to_f)))
    }
    
    return result
  end
  
  def make_curvepoint(point)
    ab = linear_interpolation(@a,@b,point)
    bc = linear_interpolation(@b,@c,point)
    cd = linear_interpolation(@c,@d,point)
    
    abbc = linear_interpolation(ab,bc,point)
    bccd = linear_interpolation(bc,cd,point)
    return linear_interpolation(abbc,bccd,point)    
  end    
       
    
end

class SVG_M

  def initialize (x, y)
    @x = x;
    @y = y;
  end
  
  def SVG_M.relative (x, y, xadd, yadd)
    return SVG_M.new(x+ xadd, y + yadd)
  end  


  def to_SEXP
    return "(" + (@x.round.to_s) + " " + (@y.round.to_s) +")"
  end
  
  def to_s
    return "Move-To:\n" +"x: " + @x.to_s + ", y: " + @y.to_s + "\n"
  end  

end


class State

  def initialize()
    @points = Array.new()
    @result = Array.new()
    @current_pos = Array.new(2)
  end
  
  def add_element(type,points)
    case type
      when "M"
        @result.push(SVG_M.new(points[0],points[1]));
        @current_pos[0] = points[0];
        @current_pos[1] = points[1];
      when "C"
        @result.push(SVG_C.new(@current_pos[0],@current_pos[1],points[2],points[3],points[4],points[5],points[6],points[7]))
        @current_pos[0]=points[6];
        @current_pos[1]=points[7];
      when "c"
        @result.push(SVG_C.relative(@current_pos[0],@current_pos[1],points[2],points[3],points[4],points[5],points[6],points[7],@current_pos[0],@current_pos[1]))
        @current_pos[0] = (@current_pos[0] + points[6])
        @current_pos[1] = (@current_pos[1] + points[7])
    end
  end
  
  def get_result
    @result
  end
end

class SVG_Code
  
  def initialize(codestring)
  @code = codestring;
  @char = @code.split(" ")[0];
  @code = @code.split(" ")[1];
  #@split_code = splitline(@code);
  @strokes = split_strokes(@code);
  @svg_rep = parse;
  end
  
  def print_char
    print @char;
  end
 
  def splitline(line)
    return (line.gsub("-",",-")).gsub("c",",c,").gsub("C","C,").gsub("M","M,").gsub("[","").gsub(";",",;,").gsub(",,",",").split(/,/);
  end
  
  def split_elements(strokes)
    result = strokes.map {|stroke| 
      stroke.gsub("-",",-").gsub("c",",c,").gsub("C","C,").gsub("M","M,").gsub("[","").gsub(";",",;,").gsub(",,",",").split(/,/);
    }
  end  
  
  def split_strokes(line)
    return line.split(";")
  end
  
  def print_strokes
    print split_strokes(@code).join("\n");
  end
  
  def parse
  
    result = Array.new;
    
    @strokes.each{|stroke|
    
      result.push(parse_stroke(stroke))      
      
    }
    
    return result
    
  end
  
  def parse_stroke(stroke)
 
    elements = stroke.gsub("-",",-").gsub("c",",c,").gsub("C",",C,").gsub("M","M,").gsub("[","").gsub(";",",;,").gsub(",,",",").split(/,/);
    
    type = "N"
    position = 0;
    points = Array.new(8);
    state = State.new()
    #Stupid and wrong, but it works. I have been coding all day and want to go to bed.
    elements.each{|element|
      case element
        when "M"
          position = 0;
          state.add_element(type,points);
          type = "M";
        when "C"
          position = 2;
          state.add_element(type,points);
          type = "C";
        when "c"
          position = 2;
          state.add_element(type,points);
          type = "c";
        else
          points[position]=element.to_f
          position +=1;
             
      end
   }
   state.add_element(type,points);
   state.get_result;
  end
  
  def add_element(type,points, result)
    case type
      when "c"
        print "add_element: c\n"
        print points.join("\n")
        return SVG_C.relative(points[0],points[1],points[2],points[3],points[4],points[5],points[6],points[7],points[0],points[1])
      when "C"
        print "add_element: C\n"
        print points.join("\n")
        return SVG_C.new(points[0],points[1],points[2],points[3],points[4],points[5],points[6],points[7])  
      when "M"
        print "add_element: M\n"
        print points.join("\n")
        return SVG_M.new(points[0],points[1])
    end
  end
  
  
  def print_split
  print split_elements(@code).join("\n");
  print "\n"
  end
  
  def print_code
  print @code
  end
  
  def to_s
      sexp = @svg_rep.map { |element|
      
      element.map{ |element2|
        if element2 != nil
          element2.to_s
        end  
        }
    }
    return sexp.join(" ");
  end
  
    
  def to_SEXP
    sexp = @svg_rep.map { |element|
      "(" + element.map{ |element2|
        if element2 != nil
          element2.to_SEXP
        end  
        }.join(" ") + ")\n"
    }
    sexp = sexp.join(" ");
    sexp = "(character (value " + @char +") (width 109) (height 109) (strokes " + sexp + "))";
    return sexp
  end  
  
  def print_SEXP
    print to_SEXP
  end
end  

class SVG_S < SVG_C

end

# reflect reflektiert einen Punkt point an einem Spiegelpunkt mirror und gibt den reflektierten Punkt zurück.
def reflect(point, mirror)
  xd = mirror[:x] - point[:x]
  yd = mirror[:y] - point[:y]
  return {:x => xd+mirror[:x], :y =>yd+mirror[:y]}
end


=begin lines = IO.read("kanjisstrokes.txt").split("\n")
lines.each do |line|

  temp = SVG_Code.new(line);
  temp.print_SEXP;

end
=end
#svg = SVG_Code.new("M10.25,33.29c0.37,0.51,0.76,0.94,0.92,1.58c1.29,5.07,3.34,18.54,4.23,27.63;M11.58,35.22c6.92-1.22,17.55-2.56,21.92-3.23c1.6-0.24,2.56,1.44,2.33,2.87,c-0.95,5.92-3.05,14.07-4.46,22.25;M15.07,59.05c5.14-0.75,11.33-1.05,18.39-2.21;[,M45.16,22.49c0.98,0.48,2.75,0.55,3.74,0.48c6.6-0.47,28.89-4.77,38.17-4.77c1.63,0,2.61,0.23,3.42,0.47;M40.27,49.86c1.44,0.56,4.09,0.7,5.53,0.56c10.65-1.05,32.31-3.88,47.88-3.82,c2.4,0.01,3.84,0.27,5.05,0.55;M67.25,23.66c0.74,0.88,1.69,2.87,1.69,5.79c0,12.8-0.72,58.43-0.72,63.2c0,10.09-7.63,0.19-8.61-0.71;
#");

#saru = SVG_Code.new("M37.82,14.75c0.11,0.93-0.05,1.89-0.61,2.65c-5.23,6.98-10.65,12-23.34,19.61;M18.05,17.24C44.21,39.08,33,107.75,20.64,90.63;M29.33,42.01c0.1,1.41,0,2.26-0.62,3.53c-3.67,7.62-7.62,12.44-16.49,20.99;[,M47.47,22.9c1.78,0.48,3.8,0.47,5.38,0.2c6.91-1.19,17-2.29,22.91-2.72c1.73-0.13,3.42-0.29,5.1,0.24;M62.67,10.62c0.73,0.73,1.13,2.13,1.13,3.53c0,4.86-0.05,15.69-0.05,18.86;M40.21,35.75c2.42,0.63,5.11,0.45,7.32,0.19c12.35-1.44,26.16-3,37.48-3.51,c2.38-0.1,4.65-0.22,6.96,0.44;[,M47.28,45.29c0.72,0.72,0.97,1.46,1.2,2.14c0.64,1.89,1.24,4.89,1.99,8.28,c0.32,1.44,0.38,2.45,0.65,4.01;M49.16,46.17c7.95-1.21,20.45-2.69,27.46-3.12c2.73-0.17,4.52,0.33,3.83,3.35,c-0.58,2.6-0.71,3.73-1.65,7.25;M52.1,57.5c5.29-0.79,15.51-1.78,23.19-2.46c1.85-0.16,3.61-0.32,5.2-0.48;M61.06,59.4c0.12,1.09-0.23,2.11-0.91,2.96c-3.78,4.77-9.82,10.83-20.93,18.9;M54.8,72.19c0.75,0.75,1,1.93,1,3.2c0,7.08-0.24,17.53-0.24,18.73s0.88,1.88,2.01,0.98,c1.12-0.9,9.18-6.97,12.78-9.84;M84.14,61.36c0,0.64-0.07,1.48-0.34,1.82c-1.92,2.44-4.24,4.45-10.7,9.33;M62.64,67.46c4.34,0.51,12.11,9.29,24.43,20.59c1.9,1.74,3.69,2.95,5.77,3.96;
#");

test = SVG_Code.new("艤 M27.25,12.92c0.5,1.08,1.28,2.67,0.67,4c-1.42,3.08-2.16,4.72-4.08,9.33;M18.42,28.75c0.8,1.27,0.98,3.12,0.98,4.71s0.11,22.01,0.2,24.86C20,70.81,15.5,86.5,9.75,92.75;M19.75,29.92c3.51-0.61,11.83-2.39,15-3c3.17-0.61,3,1.38,3,3.5c0,2.12-0.38,52.8-0.38,55.83,c0,14.25-5.28,4.11-5.95,3.5;M24.36,36.44c1.47,1.74,5.14,6.36,5.51,8.38;M26.25,56.47c1.78,1.5,1.83,2.41,1.83,3.61c0,1.2,0.17,15.67,0,18.67;M10.75,56.08c1.25,1.17,2.86,1.28,4,1c1.14-0.28,27.33-8.92,28.75-8.92;[,M51.47,13.32c3.07,1.66,7.92,6.81,8.69,9.38;M77.92,10.08c0.33,0.92,0.51,1.22,0,2.5c-1.17,2.92-2.5,6.2-5.57,9.46;M50.08,26.42c0.51,0.11,3.33,0.72,3.83,0.67c2.07-0.22,21.56-2.37,26.17-2.33c0.85,0.01,5.07-0.06,5.5,0;M66.28,28.21c0.68,0.3,1.08,1.36,1.22,1.97c0.14,0.61,0,9.71-0.14,13.5;M53.08,35.75c0.48,0.28,3.01,0.03,3.5,0c4.67-0.25,17.04-1.76,21.17-1.67c0.8,0.02,4.43-0.64,4.83-0.5;M46.75,44.75c0.82,0.33,4.19,0.82,5,0.67c3.33-0.64,26.8-2.83,35.83-3.5c1.37-0.1,4.48,0.5,5.17,0.67;[,M60.1,49.79c0.04,0.24,0.16,0.66-0.08,0.97c-1.99,2.44-6.66,6.1-15.1,9.26;M43.25,64.42c1.15,0.44,3.5,1.08,6.5,0.83c4.71-0.39,26.57-4.02,39.33-5c1.91-0.15,5.21,0.45,6.17,0.67;M56.42,57.42c0.08,0.28,1.7,1.42,1.78,3.16c0.35,8.36-0.22,28.32-0.22,31.17c0,8.76-5.55,1.01-7.05-0.49;M43.42,82.08c1.83,1.17,2.97,0.96,4.67-0.17c1-0.66,14.74-10.73,18.98-13.92;M67.42,47.58c2.33,1.42,3.61,3.1,3.83,5.17c1.88,17.33,8,31.75,19,40.33c9.44,7.36,7-0.58,6.33-7.83;M86.11,66.37c0.06,0.54,0.13,1.39-0.12,2.16c-1.48,4.56-8.12,15.06-19.73,21.18;M79.19,47.59c2.61,1.41,6.78,4.62,8,7.03;
");

#test = SVG_Code.new("吁 M10.25,33.29c0.37,0.51,0.76,0.94,0.92,1.58c1.29,5.07,3.34,18.54,4.23,27.63;M11.58,35.22c6.92-1.22,17.55-2.56,21.92-3.23c1.6-0.24,2.56,1.44,2.33,2.87,c-0.95,5.92-3.05,14.07-4.46,22.25;M15.07,59.05c5.14-0.75,11.33-1.05,18.39-2.21;[,M45.16,22.49c0.98,0.48,2.75,0.55,3.74,0.48c6.6-0.47,28.89-4.77,38.17-4.77c1.63,0,2.61,0.23,3.42,0.47;M40.27,49.86c1.44,0.56,4.09,0.7,5.53,0.56c10.65-1.05,32.31-3.88,47.88-3.82,c2.4,0.01,3.84,0.27,5.05,0.55;M67.25,23.66c0.74,0.88,1.69,2.87,1.69,5.79c0,12.8-0.72,58.43-0.72,63.2c0,10.09-7.63,0.19-8.61-0.71;");

#svg.print_split;

#saru.print_split;
#print saru.to_s;
#saru.print_strokes;

#print saru.to_SEXP

#lalala = SVG_Code.new("M13.03,37.07c0.35,0.2,2.45,0.33,3.39,0.26c4.05-0.33,16.54-1.79,23.04-2.77c0.94-0.14,2.21-0.2,2.8,0;M29.36,14c0.91,0.47,2.04,1.5,2.04,4.42c0,0.95-0.12,72.25-0.3,78.08;M30.94,38.28c-6.23,16.34-9.69,23.25-19.33,37.56;M32.97,44.9c2.37,1.59,5.28,5.76,7.28,8.85;[,M66.54,12.25c0.61,0.47,1.61,2.29,1.61,3.22c0,3.45-0.19,6.54-0.08,9.46;M44.82,26.63c1.06,0.1,3.46,0.64,4.49,0.56c10.84-0.82,30.17-3.88,41.45-4.18,c1.74-0.05,2.63,0.05,3.93,0.71;[,M55.28,33.67c0.41,0.27,0.84,0.49,1.02,0.82c1.43,2.63,1.63,9.89,2.61,14.61;M56.87,35.36c8.63-1.52,18.37-3.2,23.31-3.59c1.81-0.14,2.89,1.74,2.64,2.56,c-1.07,3.41-1.55,5.7-3.14,10.4;M58.93,47.6c5.73-0.36,15.16-1.73,23.02-2.28;[,M48.25,56.77c0.47,1.16,1.27,2.05,1.27,4.15c0,5.84-0.2,26.34-0.2,34.59;M49.93,59.55c6.42-0.46,37.4-3.76,38.58-4.04c2.92-0.7,4.06,1.46,4.06,4.7,c0,10.28-0.32,18.53-1.07,28.87c-0.65,8.89-5,3.67-6.9,1.5;[,M59.06,67.7c0.25,0.29,0.5,0.53,0.61,0.89c0.86,2.87,1.89,9.76,2.48,14.9;M60.61,69.14C67.5,67.5,72,67,75.62,66.62c1.19-0.13,2.31,1.18,2.2,2.56c-0.29,3.44-1.37,5.45-2.3,10.08,;M62.27,81.48c4.98,0,11.23-0.81,14.81-0.81;
#")

#print lalala.to_SEXP
#print c.to_s
#print svg.to_SEXP
#rint svg.to_s

