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

class SVG_Code
  
  def initialize(codestring)
  @code = codestring;
 # @split_code = splitline(@code);
  
  @svg_rep = parse;
  end
 
  def splitline(line)
    return (line.gsub("-",",-")).gsub("c",",c,").gsub("C","C,").gsub("M","M,").gsub("[","").gsub(",,",",").split(/,|;/);
  end
  
  def parse
    complete = Array.new
    @code.each { |line|
      result  = Array.new
      points  = Array.new(8,0)
      counter = 0;

      type = "N"
      splitline(line).each{ |element|
        
        push_it = false
        
        case element
          when "M"

            print "Im M-Zweig\n"
            counter = 0;
            type = element
            push_it=true;            
          when "C"

            print "Im C-Zweig\n"
            counter = 2;
            type = element          
            push_it=true;
          when "c"

            print "Im c-Zweig\n"
            counter = 2;
            type = element
            push_it=true;
          else
            print "im elsezweig\n"
            print element
            print "\n"
            points[counter] = element.to_f
            counter += 1;       
        end
        
        print element
        print "\n"
        if (type != "N") && push_it
          result = add_element(type,points, result)
        end   
      }
      if type != "N"
        result = add_element(type,points, result)
      end  
      complete.push(result)
    }
    return complete
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
  print @split_code.join("\n");
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
#svg.print_split;


c = SVG_C.new(100,200,100,100,250,100,250,200);
#print c.to_s
#print svg.to_SEXP
print svg.to_s
