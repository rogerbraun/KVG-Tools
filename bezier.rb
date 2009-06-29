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
    sexp = "("
    make_curvepoint_array(20).each { |point|
      
      sexp += "(" + (point["x"].round.to_s) + " " + (point["y"].round.to_s) + ")";
    
    }    
    sexp += ")"
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
    return "((" + (@x.round.to_s) + " " + (@y.round.to_s) +"))"
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
  @split_code = splitline(@code);
  @strokes = split_strokes(@code);
  @svg_rep = parse;
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
 
    elements = stroke.gsub("-",",-").gsub("c",",c,").gsub("C","C,").gsub("M","M,").gsub("[","").gsub(";",",;,").gsub(",,",",").split(/,/);
    
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
      element.map{ |element2|
        if element2 != nil
          element2.to_SEXP
        end  
        }
    }
    return sexp.join(" ");
  end  
end  

svg = SVG_Code.new("M10.25,33.29c0.37,0.51,0.76,0.94,0.92,1.58c1.29,5.07,3.34,18.54,4.23,27.63;M11.58,35.22c6.92-1.22,17.55-2.56,21.92-3.23c1.6-0.24,2.56,1.44,2.33,2.87,c-0.95,5.92-3.05,14.07-4.46,22.25;M15.07,59.05c5.14-0.75,11.33-1.05,18.39-2.21;[,M45.16,22.49c0.98,0.48,2.75,0.55,3.74,0.48c6.6-0.47,28.89-4.77,38.17-4.77c1.63,0,2.61,0.23,3.42,0.47;M40.27,49.86c1.44,0.56,4.09,0.7,5.53,0.56c10.65-1.05,32.31-3.88,47.88-3.82,c2.4,0.01,3.84,0.27,5.05,0.55;M67.25,23.66c0.74,0.88,1.69,2.87,1.69,5.79c0,12.8-0.72,58.43-0.72,63.2c0,10.09-7.63,0.19-8.61-0.71;
");

saru = SVG_Code.new("M37.82,14.75c0.11,0.93-0.05,1.89-0.61,2.65c-5.23,6.98-10.65,12-23.34,19.61;M18.05,17.24C44.21,39.08,33,107.75,20.64,90.63;M29.33,42.01c0.1,1.41,0,2.26-0.62,3.53c-3.67,7.62-7.62,12.44-16.49,20.99;[,M47.47,22.9c1.78,0.48,3.8,0.47,5.38,0.2c6.91-1.19,17-2.29,22.91-2.72c1.73-0.13,3.42-0.29,5.1,0.24;M62.67,10.62c0.73,0.73,1.13,2.13,1.13,3.53c0,4.86-0.05,15.69-0.05,18.86;M40.21,35.75c2.42,0.63,5.11,0.45,7.32,0.19c12.35-1.44,26.16-3,37.48-3.51,c2.38-0.1,4.65-0.22,6.96,0.44;[,M47.28,45.29c0.72,0.72,0.97,1.46,1.2,2.14c0.64,1.89,1.24,4.89,1.99,8.28,c0.32,1.44,0.38,2.45,0.65,4.01;M49.16,46.17c7.95-1.21,20.45-2.69,27.46-3.12c2.73-0.17,4.52,0.33,3.83,3.35,c-0.58,2.6-0.71,3.73-1.65,7.25;M52.1,57.5c5.29-0.79,15.51-1.78,23.19-2.46c1.85-0.16,3.61-0.32,5.2-0.48;M61.06,59.4c0.12,1.09-0.23,2.11-0.91,2.96c-3.78,4.77-9.82,10.83-20.93,18.9;M54.8,72.19c0.75,0.75,1,1.93,1,3.2c0,7.08-0.24,17.53-0.24,18.73s0.88,1.88,2.01,0.98,c1.12-0.9,9.18-6.97,12.78-9.84;M84.14,61.36c0,0.64-0.07,1.48-0.34,1.82c-1.92,2.44-4.24,4.45-10.7,9.33;M62.64,67.46c4.34,0.51,12.11,9.29,24.43,20.59c1.9,1.74,3.69,2.95,5.77,3.96;
");

#svg.print_split;

#saru.print_split;
#print saru.to_s;
#saru.print_strokes;

print saru.to_SEXP

c = SVG_C.new(100,200,100,100,250,100,250,200);
#print c.to_s
#print svg.to_SEXP
#rint svg.to_s

