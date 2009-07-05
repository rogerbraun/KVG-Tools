require 'cairo'
require "kvg2sexp.rb"

def draw_to_context(cr, points)

  cr.set_source_color(Cairo::Color.parse(:black))
  cr.set_line_width(0.1);

  points.each do |point|
  
    cr.rectangle(point.x,point.y,2,2);
    cr.fill;
  
  end
  
end

def draw_to_file(character, number)
  surface = Cairo::ImageSurface.new(109,109)
  cr = Cairo::Context.new(surface)
  cr.set_source_color(Cairo::Color.parse(:white))
  cr.paint
  
  draw_to_context(cr,character.to_points)
  
  cr.target.write_to_png("test-" + number.to_s + ".png")
  
end


testc = "吁 M10.25,33.29c0.37,0.51,0.76,0.94,0.92,1.58c1.29,5.07,3.34,18.54,4.23,27.63;M11.58,35.22c6.92-1.22,17.55-2.56,21.92-3.23c1.6-0.24,2.56,1.44,2.33,2.87,c-0.95,5.92-3.05,14.07-4.46,22.25;M15.07,59.05c5.14-0.75,11.33-1.05,18.39-2.21;[,M45.16,22.49c0.98,0.48,2.75,0.55,3.74,0.48c6.6-0.47,28.89-4.77,38.17-4.77c1.63,0,2.61,0.23,3.42,0.47;M40.27,49.86c1.44,0.56,4.09,0.7,5.53,0.56c10.65-1.05,32.31-3.88,47.88-3.82,c2.4,0.01,3.84,0.27,5.05,0.55;M67.25,23.66c0.74,0.88,1.69,2.87,1.69,5.79c0,12.8-0.72,58.43-0.72,63.2c0,10.09-7.63,0.19-8.61-0.71;
艤 M27.25,12.92c0.5,1.08,1.28,2.67,0.67,4c-1.42,3.08-2.16,4.72-4.08,9.33;M18.42,28.75c0.8,1.27,0.98,3.12,0.98,4.71s0.11,22.01,0.2,24.86C20,70.81,15.5,86.5,9.75,92.75;M19.75,29.92c3.51-0.61,11.83-2.39,15-3c3.17-0.61,3,1.38,3,3.5c0,2.12-0.38,52.8-0.38,55.83,c0,14.25-5.28,4.11-5.95,3.5;M24.36,36.44c1.47,1.74,5.14,6.36,5.51,8.38;M26.25,56.47c1.78,1.5,1.83,2.41,1.83,3.61c0,1.2,0.17,15.67,0,18.67;M10.75,56.08c1.25,1.17,2.86,1.28,4,1c1.14-0.28,27.33-8.92,28.75-8.92;[,M51.47,13.32c3.07,1.66,7.92,6.81,8.69,9.38;M77.92,10.08c0.33,0.92,0.51,1.22,0,2.5c-1.17,2.92-2.5,6.2-5.57,9.46;M50.08,26.42c0.51,0.11,3.33,0.72,3.83,0.67c2.07-0.22,21.56-2.37,26.17-2.33c0.85,0.01,5.07-0.06,5.5,0;M66.28,28.21c0.68,0.3,1.08,1.36,1.22,1.97c0.14,0.61,0,9.71-0.14,13.5;M53.08,35.75c0.48,0.28,3.01,0.03,3.5,0c4.67-0.25,17.04-1.76,21.17-1.67c0.8,0.02,4.43-0.64,4.83-0.5;M46.75,44.75c0.82,0.33,4.19,0.82,5,0.67c3.33-0.64,26.8-2.83,35.83-3.5c1.37-0.1,4.48,0.5,5.17,0.67;[,M60.1,49.79c0.04,0.24,0.16,0.66-0.08,0.97c-1.99,2.44-6.66,6.1-15.1,9.26;M43.25,64.42c1.15,0.44,3.5,1.08,6.5,0.83c4.71-0.39,26.57-4.02,39.33-5c1.91-0.15,5.21,0.45,6.17,0.67;M56.42,57.42c0.08,0.28,1.7,1.42,1.78,3.16c0.35,8.36-0.22,28.32-0.22,31.17c0,8.76-5.55,1.01-7.05-0.49;M43.42,82.08c1.83,1.17,2.97,0.96,4.67-0.17c1-0.66,14.74-10.73,18.98-13.92;M67.42,47.58c2.33,1.42,3.61,3.1,3.83,5.17c1.88,17.33,8,31.75,19,40.33c9.44,7.36,7-0.58,6.33-7.83;M86.11,66.37c0.06,0.54,0.13,1.39-0.12,2.16c-1.48,4.56-8.12,15.06-19.73,21.18;M79.19,47.59c2.61,1.41,6.78,4.62,8,7.03;
直 M25.15,27.9c1.92,0.35,5.43,0.36,7.35,0.19c16.72-1.53,29.48-2.6,46.27-3.74c3.19-0.22,5.11,0.04,6.71,0.2,;M53.73,12.51c1.38,1.38,2.01,3.12,2.01,4.89c0,3.35,0.09,8.6,0.09,19.6;[,M36.56,37.49c1.19,1.26,1.66,3.14,1.66,4.57c0,1.2,0.39,24.33,0.19,37.94c-0.02,1.46-0.04,2.82-0.07,4.01;M39.52,39.91c8.14-0.78,28.45-3.08,30.99-3.25c2.46-0.17,3.99,1.59,4.19,4.16,c0.11,1.44-0.12,22.29-0.19,36.93c-0.01,1.37-0.01,2.69-0.01,3.94;M39.61,52.51c8.01-0.63,27.51-2.38,33.61-2.61;M39.63,65.91c8.64-0.56,24.87-2.16,33.96-2.49;M39.75,80.42c6.02-0.5,29.3-2.32,33.63-2.32;M19.75,80.5c1,1.25,1.75,2.75,1.75,5.25s-1.12,29.88-1.75,35.75c-0.28,2.6,0.27,4.15,3.25,3.75,c20.5-2.75,41.5-4,63.75-4c2.75,0,5.5,0.5,7.5,1.25;
慧 M19.41,20.34c1.26,0.4,3.3,0.37,4.61,0.27c5.19-0.41,13.1-1.35,19.48-2.22,c1.65-0.23,3.39-0.31,5.04,0.01;M20.43,30.18c0.99,0.71,3.33,0.44,4.45,0.36c6.43-0.5,11.99-1.41,18.12-2.28,c1.17-0.17,2.75-0.26,4.05-0.07;M18.88,40.63c0.85,1.41,2.24,1.24,4.08,0.8c6.91-1.66,17.17-3.81,26.78-6.36;M34.04,10.94c0.95,0.95,1.27,1.81,1.35,3.2c0.36,5.98,1.61,20.23,2.45,31.92;[,M55.82,19.15c1.8,0.58,3.57,0.42,5.43,0.31c6.03-0.37,16.04-1.61,21.5-1.84,c1.35-0.06,2.71-0.12,4.05,0.14;M57.64,27.76c1.58,0.56,3.46,0.62,5.12,0.47c5.18-0.48,13.79-1.63,18.62-1.81,c1.16-0.04,2.34-0.06,3.47,0.18;M55.87,37.54c1.48,0.44,3.71,0.43,5.25,0.34c8.87-0.54,16.88-1.51,25-2.17,c1.39-0.11,2.86-0.01,4.24,0.24;M72.09,9.03c0.88,0.88,1.04,1.97,0.85,3.62c-0.77,7.05-2.19,20.73-3.68,31.51;[,M26.74,51.56c1.88,0.56,3.51,0.77,5.68,0.58c14.83-1.27,31.12-2.09,42.71-2.93,c3.06-0.22,4.46,1.84,3.98,3.52c-1.24,4.39-2.08,8.4-3.73,15.94;M25.7,60.67c2.55,0.7,4.37,0.79,7.05,0.6c15.94-1.09,27.99-2.05,43.7-2.75;M25.77,70.81c2.48,0.82,4.63,0.83,6.99,0.73c11.01-0.46,30.41-2.27,41.44-2.46c1.89-0.03,3.08,0,4.5,0.1;[,M20.89,82.05c0.38,1.88-3.78,10.18-6.81,13.31;M32.83,80.36c6.17,9.48,15.92,17.96,39.7,18.07C84,98.49,85,95.88,75.93,90.34;M52.66,78.5c1.95,4.52,4.29,9.3,6.38,2.37;M78.88,76.98c4.37,2.27,8.74,5.89,12.35,10.68;
慙 M18.25,21.66c0.65,0.29,1.85,0.35,2.5,0.29c9.1-0.88,19.12-1.84,28.37-2.6,c1.09-0.09,1.74,0.14,2.28,0.28;M20.74,30.23c0.46,0.35,1.06,1.35,1.14,1.82c0.63,3.34,1.83,9.74,2.72,16.07;M22.98,31.12c7.07-0.67,20.19-2.67,25.01-2.78c2-0.04,2.41,0.92,2.32,1.96,c-0.29,3.6-1.81,9.19-2.98,15.78;M23.76,38.73c5.33-0.17,15.16-1.79,25.39-2.24;M25.09,46.7c6.19-0.69,14.17-2.04,22.24-2.04;M15.72,56.13c0.87,0.54,2.43,0.61,3.32,0.54c8.91-0.66,21.33-2.73,29.63-3.37,c1.44-0.11,2.76-0.12,3.48,0.15;M33.32,10.84c0.63,0.41,2.09,2.3,2.09,3.93c0,6.12-0.52,48.36-0.65,53.54;[,M83.25,11.5c0.05,0.27-0.27,1.31-0.61,1.6c-4.67,4.02-10.15,6.57-20,10.03;M60.3,21.85c0.75,1.32,0.74,2.58,0.74,4.01c0,14.19-0.04,29.88-10.72,38.38;M62.13,34.49c0.39,0.15,1.9,0.25,2.92,0.09c5.64-0.93,18.35-2.65,24.75-3.11c1.03-0.08,2.81-0.15,3.45,0,;M76.82,35.45c0.83,0.46,1.33,2.09,1.49,3.02c0.16,0.93,0,22.71-0.17,28.53;[,M24.06,79.38c0.36,2.28-3.65,12.36-6.56,16.17;M35.25,75.32c6.26,12.2,13.5,22.43,40.3,22.93c11.65,0.22,12.41-3.25,2.69-8.8;M54.83,75.07c1.95,5.25,4.79,10.5,6.88,2.46;M80.05,73.8c5.7,3.2,9.95,6.95,14.1,12.61;
挙 M26.5,17.12c3.95,3.81,8.19,10.47,8.75,12.38;M45.75,13c3,3.12,7.25,8.25,8.75,13;M78.5,12.75c0.38,1.12,0.1,2.63-0.5,3.75c-2,3.75-7.38,11.25-10.5,14.5;M16.75,38.2c3.5,0.55,7.59,0.15,11.15-0.22c11.88-1.23,38.95-3.93,55.48-4.94,c3.59-0.22,7.88-0.17,11.38,0.5;M40.54,38.68c0.07,0.61-0.15,1.4-0.65,2.18C35.5,47.75,27.75,55.5,14.75,63.65;M61.75,36c2.67,1.47,17.58,14.43,24.85,20.42c2.23,1.84,4.65,3.2,7.77,4.33;[,M62.17,42.88c-0.05,0.83-0.82,1.76-1.38,2.2c-3.23,2.53-11.6,6.84-24.11,10.15;M31.12,63.33c1.96,0.58,4.83,0.54,6.8,0.24c9.07-1.36,20.95-3.23,29.56-4.35,c2.53-0.33,5.27-0.59,8.05-0.25;M22.68,76.46c2.15,0.69,5.67,0.3,7.82,0.06c13.05-1.45,32.67-3.54,46.62-4.28,c3.61-0.19,7.31-0.46,10.88,0.22;M50.85,50.98c6.9,9.77,7.9,23.77,5.47,41.08c-0.68,4.87-4.95,4.31-8.05,0.5;
司 M24.5,18.5c2.81,0.47,5.53,0.55,8.36,0.24C49.81,16.86,75.38,14.34,79.5,14c4.5-0.38,5.75,1.25,5.75,5,c0,2.5,0.25,63.5,0.25,69.25c0,13.62-6.38,6.25-10.5,2.5;M26,39.96c1.91,0.65,4.07,0.28,6.02,0.08c6.49-0.67,18.39-2.28,24.98-2.77c1.87-0.14,3.65-0.2,5.5,0.17;[,M25.75,56.66c0.82,0.67,1.53,2.03,1.63,3.09c0.87,3.36,1.47,9.16,2.07,14.14,c0.15,1.27,0.31,2.49,0.47,3.6;M28.59,58.35c9.64-1.76,21.62-3.46,27.44-4.15c2.95-0.35,4.88,0.76,4.07,3.96,c-0.97,3.86-2.15,6.8-4.14,13.36;M30.79,75.19c4.79-0.48,15.41-1.58,23.97-2.47c1.37-0.14,2.69-0.28,3.92-0.41;
驃 M15.24,19.29c-0.02,5.44-0.21,41.27-0.99,44.44;M12.98,19.06c0.8-0.02,2.74-0.07,3.79-0.14c7.82-0.55,19.9-3.45,22.26-3.82c0.94-0.15,2.53-0.26,3-0.03;M28.31,18.98c0.25,0.4,0.96,0.93,0.95,1.57c-0.02,6.51-0.06,29.49-0.25,39.72;M15.66,34c6.26-0.62,19.25-3.19,21.94-3.6c0.94-0.15,2.53-0.26,3-0.03;M15.76,46.25c6.26-0.62,19.75-3.21,22.44-3.63c0.94-0.15,2.53-0.26,3-0.03;M14.99,63.09c6.17-1.49,21.04-3.76,24.43-4.39c4.33-0.8,5.19-0.04,4.95,3.81,c-0.67,10.91-3.87,24.99-8.62,32.1c-3.7,5.54-6.32,0.43-7.21-0.91;M11.21,74.77c0.26,5.64-0.52,10.61-0.79,11.74;M17.95,72.45c1.24,2.47,2.28,5.58,2.57,9.99;M24.74,68.87c0.78,1.27,3.56,5.46,3.9,9.6;M32.38,67c1.35,2.37,3.58,4.81,4.06,7.95;[,M51.12,14.89c0.99,0.41,2.8,0.52,3.79,0.41c6.3-0.7,28.33-3.79,34.94-4.14c1.65-0.09,2.64,0.19,3.46,0.4,;[,M50.07,25.26c0.29,0.31,0.59,0.58,0.71,0.97c1.01,3.12,2.71,11.72,3.4,17.32;M51.88,26.78c7.11-1.25,36.08-4.68,39.73-5.22c2.14-0.32,3.14,1.43,2.95,3.47,c-0.35,3.83-1.56,9.32-3.26,14.75;M62.94,16.11c0.77,0.47,1.29,2.12,1.39,3.08c0.3,2.84,0.92,13.31,0.72,20.62;M77.92,13.29c0.77,0.47,1.16,2.6,0.8,4.73c-0.63,3.81-0.73,12.22-1.2,20.15;M54.48,41.32c8.52-1.57,32-3.45,37.46-3.93;[,M55.94,52.69c0.91,0.49,2.57,0.61,3.48,0.49C66.16,52.3,79,50.5,85.48,49.59,c1.5-0.21,2.42,0.23,3.18,0.48;M49.38,66.24c1.22,0.52,3.44,0.6,4.66,0.52c9.01-0.63,26.67-3.81,39.85-4.49,c2.02-0.1,3.24,0.25,4.25,0.5;M71.71,67.61c0.1,0.45,1.42,2.33,1.42,5.16c0,6.71-0.01,16.04-0.01,20.68c0,6.39-5.14,2.37-7.25,0.27;M59.88,75.52c0.04,0.51,0.25,1.38-0.08,2.06c-2.29,4.67-8.04,9.92-18.16,17.2;M85.19,77.42c4.46,2.98,11.75,11.9,12.87,16.53;
隆 M15.42,21.67c1.52,0.6,2.99,0.67,4.61,0.28c5.48-1.32,8.6-2.07,12.64-3.03c3.08-0.73,4.27,1.13,3.17,3.58,c-1.46,3.25-5.21,10.62-8.58,16.75;M27.25,39.25c12.5,9.38,10.25,32.25-1.33,25.25;M17.37,23c0.75,0.75,0.96,1.75,0.96,3.5c0,3.12,0.02,42.97,0.03,61.5c0,5.2,0,8.65,0,9;[,M59.79,13.25c0.08,1-0.17,1.88-0.6,2.77c-2.7,5.58-6.6,12.85-15.12,20.46;M60.08,20.14c1.39,0.14,2.95,0.16,4.3-0.1c3.65-0.7,8.29-2.34,11.26-3.02c2.42-0.55,3.61,0.61,2.74,2.63,c-3.5,8.18-17.63,25.48-35.13,32.1;M53.89,27.94c6.33,3.93,21.42,14.08,30.6,19.68c3.27,2,6.27,3.5,10.27,4.9;[,M54.22,54.35c0.05,0.95,0.07,1.71-0.3,2.59c-1.8,4.31-4.42,9.39-9.21,15.87;M54.12,64.29c1.75,0.54,3.87,0.13,5.64-0.05c5.3-0.55,14.07-2.2,19.25-2.79,c1.9-0.21,3.62-0.45,5.36,0.17;M65.38,50.13c1,1,1.33,1.99,1.33,3.28c0,0.6-0.08,33.07-0.08,37.59;M50.37,78.08c1.93,0.56,4.58,0.21,6.52-0.12c6.52-1.1,17.32-1.91,22.87-2.31,c1.86-0.13,3.49-0.03,5.09,0.29;M37.15,92.22c3.12,0.49,5.82,0.68,8.98,0.48c10.95-0.69,28.25-1.58,39.12-2.03,c3.09-0.13,6.72,0.14,9.73,0.89;
岌 M51.8,10.88c0.61,0.36,1.91,2.71,2.03,3.43c0.12,0.72-0.08,12.1-0.2,16.62;M27.61,18.88c0.61,0.36,1.22,1.89,1.22,2.63c0,2.83-1.42,5.92-2.83,10.2c-0.52,1.58,0.91,2.84,2.3,2.48,c11.44-2.94,47.84-5.46,53.32-5.6;M81.88,16.97c0.61,0.36,1.32,2.71,1.22,3.43c-0.61,4.44-0.29,7.03-1.27,11.35;[,M40.29,47.14c0.71,1.11,0.87,3.03,0.49,4.7C38.03,64.25,31,85.75,11.39,96.85;M40.04,63.91c2.6,0.58,4.03,0.16,6.63-0.4c4.51-0.96,23.89-4,28.13-4.39c2.89-0.26,4.13,1.06,3.18,2.7,C69.25,77,52.25,89.75,30.5,98;M32.75,43.65c2.5,0.85,5.2,1.06,7.75,0.64c6.25-1.04,20.25-2.54,24.25-3.6S71.5,40.9,70,43.45,S65.5,54,64.25,59.66;M39.75,65.17c8.27,5.26,33.68,26.51,42.01,30.27c2.67,1.2,4.38,2.16,6.74,2.6;
嘗 M52.96,9.37c0.9,0.9,1.26,1.63,1.26,2.99c0,3.64-0.01,8.32-0.01,11.01;M32.02,12.08c2.84,1.66,7.08,6.56,7.79,9.13;M75.26,10.25c0.08,0.8-0.01,1.6-0.45,2.27c-1.68,2.6-3.61,4.81-7.81,9.23;[,M21.32,25.13c-0.15,3.7-3.03,12.36-4.32,14.56;M21.75,28.12c21.12-2.88,40.5-4.75,63.54-5.82c10.95-0.51,4.21,5.19-0.65,7.95;[,M37.64,32.38c0.74,0.74,0.81,0.99,0.98,1.72c0.5,2.17,0.86,3.58,1.21,4.98c0.26,1.04,0.5,2.08,0.8,3.42;M39.35,33.32c4.57-0.47,21.29-2.07,28.03-2.76c2.34-0.24,4.42,0.67,3.37,3.32,c-0.63,1.6-1.04,2.06-2.13,4.69;M41.44,41.21c5.19-0.57,15.45-1.15,23.31-1.56c2.06-0.11,3.95-0.2,5.55-0.28;[,M75.18,44.59c-0.5,1.24-1.47,1.97-2.65,2.5c-8.28,3.67-20.17,5.22-36.21,7.15;M31.75,45.07c0.92,0.92,1,2,1,3.43c0,1.38,0.05,2.25,0.05,4.94c0,7.37,2.95,8.54,26.99,8.54,c24.82,0,26.03-2.61,26.03-7.37;[,M38.05,70.98c0.86,0.86,0.92,2.15,0.92,2.98c0,0.53-0.02,10.98-0.04,18.41,c-0.01,4.05-0.02,7.21-0.02,7.35;M39.49,72.56c7-0.61,24.06-1.87,29.53-2.28c3.61-0.27,4.43,1.1,4.43,4.34c0,4.16-0.02,11.71-0.04,17.13,c-0.01,3.54-0.02,6.18-0.02,6.38;M39.95,84.52c13.55-0.77,22.18-1.52,32.2-1.97;M39.78,96.56C51,96,61.5,95.5,72.13,95.29;
朕 M19.97,20.49c0.77,0.77,1.03,1.76,1.05,3.05C21.5,58,19.38,77.12,11.25,91.89;M22.07,22.06c3.95-0.6,9.94-1.92,12.55-2.34c3.7-0.6,4.43,1.24,4.41,4.4,c-0.08,9.07-0.01,45.55-0.01,62.19c0,12.61-5.91,3.55-7.7,2.04;M22.07,40.7c5.43-0.7,10.8-1.45,15.58-1.82;M21.01,59.15c4.99-0.52,11.89-1.28,17.04-1.7;[,M51.61,20.28c2.99,2.35,7.73,9.64,8.48,13.29;M80.02,16.64c0.05,0.99,0.04,1.74-0.31,2.68c-1.93,5.19-4.41,10.86-8.7,17.76;[,M49.79,41.59c1.9,0.77,4.39,0.32,6.33,0.03c7.05-1.03,17.59-2.53,23.76-3.13,c2.11-0.21,4.14-0.41,6.23,0.09;[,M44.24,58.23c2.63,0.52,4.51,0.42,6.52,0.16c10.22-1.32,27.31-3.1,36.24-3.63,c2.79-0.17,5.24,0.08,7.97,0.72;M65.39,43.62c0.61,1,0.79,2.35,0.74,3.8C65.14,74.44,58,86,45.7,93.37;M66.45,60.14c5.46,6.4,15.33,19.43,22.4,26.5c2.04,2.04,4.15,4.23,6.5,5.66;
製 M25.63,12.8c0.03,0.37,0.15,0.99-0.05,1.49c-1.2,2.96-3.7,8.21-8.65,13.24;M24.7,20.03c1.33,0.38,3.01,0.36,4.31,0.24c5.74-0.5,11.87-1.53,17.72-2.14c1.47-0.15,2.69-0.3,4.13-0.05,;M15,32.49c2.21,0.56,4.55,0.38,6.75,0.08c9.5-1.32,21.56-2.99,29.75-3.72c2.23-0.2,4.41-0.37,6.64-0.04;M21.69,41.08c0.41,0.19,1.27,1.41,1.35,1.78c0.44,2.09,1.02,5.51,1.57,8.37C24.95,53,25.12,54,25.4,55.46,;M23.4,42.04c9.1-2.04,19.37-3.61,25.09-4.26c1.39-0.16,2.6,0.9,2.63,1.76c0.13,4.33,0.01,6.83-0.31,11.22,c-0.22,3.12-3.35,0.42-4.42-0.63;M35.39,7.88c0.93,0.93,1.57,2.49,1.57,3.52c0,0.54,0.1,26.96,0.03,40.85c-0.01,1.74-0.01,3.27-0.01,4.5;[,M68.15,14.14c0.91,0.91,1.37,2.36,1.37,3.53c0,6.74,0.14,15.19,0.05,20.83,c-0.04,2.32-0.07,4.12-0.07,5.06;M85.69,8.66c1.01,1.01,1.48,2.47,1.48,3.99c0,16.11-0.22,31.19-0.22,34.14c0,7.46-4.58,1.59-6.34-0.1;[,M56.19,51.5c0.72,0.72,1.38,1.62,1.38,3.33c0,1.42-0.12,2.54-0.12,4.98;M21.07,64.45c3.06,0.22,5.64,0.37,8.71,0c11.5-1.37,37.15-4.74,50.22-5.59c2.71-0.18,5.5-0.24,8.32,0.37;M48.95,65.28c0.09,0.58-0.07,1.86-0.67,2.58C44,73,35.38,79.88,18.37,88.96;M41.64,77.1c0.88,0.88,1.3,2.27,1.3,3.74c0,7.34-0.01,16.48-0.01,17.72c0,1.24,1.02,2.03,2.15,1.02,C48.5,96.5,55,91.25,59.17,88.05;M75.86,65.17c0.1,1.07-0.04,2.12-0.67,3.12c-1.14,1.8-2.96,3.45-6.41,6.6;M55.45,70.15c4.43,0.09,22.99,15.84,31.9,21.52c2.27,1.45,4.28,2.46,6.58,3.56;
憾 M16.12,40.12c0,7.02-3.09,17.37-3.9,19.38;M33.25,34.5c2.31,2.2,5.98,9.04,6.56,12.47;M24.62,13.75c0.88,0.88,1.21,2.38,1.21,3.75c0,0.7,0.02,55.38,0.03,74.25c0,3.54,0,5.81,0,6.25;[,M46.65,31.23c0.75,0.75,1,1.9,0.93,3.31C47,46.5,46.88,59.62,39,71.03;M43.71,30.33c2.29,0.54,4.79,0.35,6.91-0.09c7.12-1.49,16.88-3.62,26.79-5.31,c2.2-0.38,4.72-0.78,6.91-0.32;M50.02,43.52c1.35,0.11,2.78,0.07,3.54-0.17c3.18-0.97,6.18-1.72,8.99-2.57,c1.27-0.38,2.7-0.27,3.36-0.11;[,M49.04,53.74c0.67,0.67,1.21,1.4,1.33,2.18c0.68,2.13,1.4,5.14,1.97,8.31c0.2,1.12,0.39,2.27,0.55,3.41,;M51.11,54.65c5.7-1.31,9.96-2.32,13.13-2.74c2.32-0.3,3.59-0.06,3.09,2.46,c-0.52,2.64-0.65,3.97-1.62,7.88;M53.73,65.3c4.52-0.8,6.05-1.02,9.76-1.66c1-0.17,2.07-0.34,3.22-0.5;M61.55,11.47c1.22,1.19,1.94,2.28,2.53,4.78C68.75,36,77.75,56.5,89.98,65.75,c4.33,3.27,4.05,0.95,3.44-4.33;M84.83,38.14c0.04,0.63,0.08,1.64-0.08,2.55c-0.92,5.37-6.02,17.6-13.25,24.82;M75,11.75c2.41,1.23,6.27,4.03,7.4,6.14;[,M42,81.12c0.26,2.09-2.63,11.32-4.74,14.8;M51,80c7.88,13.25,17.75,18.25,32.25,18c11.22-0.19,8.25-3.75,2.99-7.05;M64.33,75.9c2.42,5.6,4.14,4.76,4.69,1.81;M85.38,75.25c4.07,3.15,6.68,6.22,9.88,11.36;
捻 M11.5,37.92c2.08,0.25,1.27,0.55,3.5,0.25c5.5-0.75,14.5-2,23.67-3.17;M27.27,14c0.48,0.92,1.67,2.49,1.76,5.52c0.4,14.55,0.24,61.94,0.24,66.9c0,14.25-6.32,3.53-7.77,2;M11,67.72c2.73,2.12,4.49,1.15,7.22-0.67c1.61-1.07,11.45-8.25,18.28-13.39;[,M64.41,12.25c0.07,0.75,0.25,1.96-0.14,2.99c-2.71,7.22-10.75,18.94-23.94,28.65;M64.24,15.35c4.15,4.79,22.01,20.45,26.58,23.96c1.55,1.19,3.54,1.7,5.09,2.04;M56.25,38.05c0.3,0.14,2.11,0.16,2.4,0.14c3.08-0.16,11.09-1.44,14.7-2.15c0.48-0.1,2.55,0.07,2.8,0.14;M48.59,49.65c0.78,0.37,1.21,0.31,3.11,0.27c8.31-0.17,21.39-2.71,26.62-3.66,c3.1-0.57,4.37,1.21,2.34,3.76c-4.27,5.37-6.02,8.7-10.68,12.69;[,M44.66,77.33c0.32,2.23-3.17,12.1-5.7,15.83;M53.57,71.76C58.5,83.25,65.65,95.13,82.92,96.1c7.08,0.4,8.08-1.6,2.17-6.24;M67.43,72.24c1.82,5.01,4.57,7.51,5.43,2.59;M86.06,69.41c4.82,2.06,8.44,3.94,12.35,10.32;
粮 M13.94,25.89c2.92,2.26,7.33,8.65,8.06,12.16;M45.01,21.47c0.03,0.37,0.05,0.96-0.05,1.49c-0.6,3.15-4.02,10.06-8.71,14.29;M11.95,45.47c0.56,0.17,2.06,0.59,3.55,0.5c5.36-0.33,20.74-2.7,26.8-3.23c1.49-0.13,1.87-0.17,2.81,0;M29.52,15.46c0.88,0.47,1.41,2.1,1.59,3.04c0.18,0.94,0,73.15-0.18,79;M31.02,45.46C27.54,56.71,19.08,72.51,11.25,79;M31.87,53.07c5.52,3.24,9.58,6.97,11.63,12.43;[,M68.21,13.25c0.83,0.45,1.33,1.12,1.5,2.02c0.17,0.9,0.17,7.17,0.17,9.42;[,M56.61,27.45c2.28-0.05,25.52-3.07,27.6-3.15c1.73-0.07,2.69,1.34,2.65,2.04,c-0.25,4.92-1.78,24.54-2.86,27.91;M57.23,40.56c5.32-0.41,23.23-2,28.34-2.32;M56.85,53.7c7.68-0.44,17.76-1.06,26.11-1.5;M53.51,25.73c1.46,0.58,2.34,2.63,2.64,3.81c0.29,1.17,0.62,59.49,0.29,62.4,c-0.29,2.63-0.9,7.52,2.23,4.66c4.16-3.82,8.19-7.48,13.28-12.46;M91.38,57.55c0.37,1.48,0.08,2.53-1.15,3.75C87,64.5,82.37,68.93,79,71;M64.38,54.48C69.02,59.16,81.27,81,88.33,88.97c3.76,4.25,5.67,5.37,7.74,6.17;
嚼 M10.25,34.5c0.33,0.43,0.67,0.79,0.82,1.33c1.15,4.27,2.96,18,3.75,25.67;M12.32,36.56c8.37-1.87,14.31-3,18.19-3.56c1.42-0.21,2.27,1.22,2.07,2.42,c-0.84,4.99-2.29,12.72-3.54,19.62;M14.51,57.99c4.56-0.63,10.57-1.37,16.84-2.34;[,M83.82,8.89c-0.32,1.11-0.79,1.47-1.69,1.76c-3.38,1.09-13.66,4.15-31.33,6.31;M49.1,21.64c0.03,0.32,0.06,0.83-0.05,1.28c-0.67,2.71-4.5,8.65-9.75,12.29;M62.38,21.08c1.83,1.35,4.74,5.54,5.2,7.63;M82.19,18.58c4.87,2.05,12.57,8.44,13.78,11.63;[,M41.78,36.22c0.26,0.26,0.53,0.48,0.65,0.81c0.92,2.64,2.03,8.44,2.67,13.2;M43.92,36.99c5.8-1.15,43.1-4.6,46.18-5.01c1.12-0.15,2.65,0.85,2.36,2.35,c-0.62,3.13-2.15,8.5-3.82,12.98;M58.07,35.24c0.04,0.42,0.65,1.23,0.78,2.24c0.44,3.24,0.71,8.59,0.84,10.11;M73.72,34.82c0.78,0.93,0.88,1.34,0.77,2.22c-0.45,3.46-1.38,8.05-1.65,9.47;M46.43,49.27c3.62-0.46,37.65-3.55,42.62-4.25;[,M42.17,56.78c0.73,0.4,1.17,1.8,1.31,2.59c0.15,0.8,0.31,39.19,0.15,41.17;M43.74,58.8c1.28-0.08,15.9-1.83,17.07-1.99c1.97-0.28,2.43,1.01,2.39,2.29,C63,65,61.58,75.64,61.58,76.14;M43.96,67.16c1.74,0,13.29-1.41,18.58-1.74;M43.88,76.21c3.54-0.37,13.73-0.89,17.66-1.58;M43.97,86.5c4.38-0.48,12.21-2.03,16.12-2.39c0.85-0.08,1.36,0.15,1.79,0.31;M43.72,96.25c4.38-0.48,13.71-2.03,17.62-2.39c0.85-0.08,1.36,0.15,1.79,0.31;[,M68.06,64.17c0.82,0.38,2.33,0.44,3.16,0.38c7.06-0.58,19.97-2.45,26.27-2.88,c1.37-0.09,2.2,0.18,2.89,0.37;M87.91,53.08c0.07,0.32,0.92,1.66,0.92,3.69c0,13.64-0.18,33.8-0.18,37.11c0,8.04-5.49,1.19-7.09,0.17;[,M72.27,73.02c2.41,1.68,6.21,6.92,6.82,9.54;
該 M23.55,14c2.52,1.5,6.5,6.17,7.13,8.5;M12.12,32.33c1.84,0.6,4.15,0.47,6.01,0.24c7.75-0.98,13.22-1.84,19.32-2.93,c1.52-0.27,3.11-0.53,4.65-0.22;M18.18,45.81c1.41,0.4,3.39,0.24,4.82,0.05c4.62-0.61,7.15-1.34,11.73-2.23,c1.12-0.22,2.15-0.33,3.29-0.13;M19.05,58.08c1.19,0.36,2.85,0.15,4.08,0.07c3.64-0.24,8.54-1.14,12.24-1.68c1-0.14,2.2-0.43,3.21-0.25;[,M17.26,70.65c0.85,0.79,1.08,2.01,1.3,3.08c0.73,3.52,1.31,8.66,2.17,13.47,c0.22,1.23,0.43,2.42,0.64,3.54;M19.19,71.87c7.31-1.38,10.62-2,16.3-2.79c3.4-0.48,4.18,0.54,3.52,3.78c-0.72,3.48-1.21,6.88-2.7,12.86,;M22.17,88.3c5.2-0.8,7.56-0.96,12.85-1.69c0.9-0.12,1.88-0.25,2.96-0.37;[,M69.01,12.24c1.25,1.25,1.6,2.51,1.6,4.23c0,4.26-0.11,6.35-0.11,11.28;M48,30.31c2.25,0.16,4.47,0.3,6.74,0.08c8.48-0.82,26.09-2.68,35.9-3.27c1.89-0.12,4.05-0.36,5.87,0.31;M67.98,32.37c0.48,1.23-0.02,2.61-0.99,3.97c-3.48,4.91-4.82,7.05-10.05,12.94,c-1.3,1.47-1.43,2.59,0.5,3.32c4.87,1.82,6.1,2.77,10.43,5.02;M82.27,40c0.15,1.38-0.46,2.46-1.21,3.54C73.52,54.35,64.43,64.03,48.5,74;M85.74,59c0.1,0.88-0.51,2.35-1.21,3.27c-9.04,12-19.9,23.48-38.53,33.48;M76.25,76.88C82.51,79.98,92.43,89.66,94,94.5;
瀝 M14.63,17c4.63,1.6,11.96,6.6,13.12,9.09;M12.25,40.75c4.68,1.72,12.08,7.07,13.25,9.75;M11.75,86.23c1.71,1.27,3.78,1.32,4.86-0.25c3.14-4.57,8.29-15.16,11.14-20.99;[,M37.3,19.16c1.51,0.68,4.29,0.75,5.81,0.68c17.56-0.79,23.44-2.77,43.21-3.04,c2.52-0.03,4.04,0.32,5.3,0.66;M42.03,20.25c0.05,1.64-0.01,2.22-0.09,4.57C41,51.5,37.5,73,26.31,89.22;[,M62.74,24c0.04,0.2,0.09,0.51-0.08,0.79c-1.01,1.66-6.78,5.31-14.68,7.55;[,M46.06,39.15c0.31,0.15,1.55,0.47,2.38,0.45c5.32-0.1,8.82-1.1,15.19-1.82,c0.82-0.09,1.86,0.18,2.38,0.33;M56.41,32.52c0.27,0.22,0.43,0.99,0.49,1.44c0.05,0.44,0,22.78-0.05,25.54;M56.12,39.3c-2.42,5.87-6.25,11.78-12.02,15.08;M58.01,43.19c2.75,1.22,5.91,3.51,7.17,6.23;[,M88.53,22.5c0.04,0.17,0.09,0.45-0.08,0.7c-1.02,1.47-6.84,4.69-14.81,6.65;[,M70.18,37.73c0.33,0.09,1.67,0.33,2.55,0.27c3.99-0.27,13.42-1.53,20.18-1.78,c0.89-0.03,2,0.11,2.55,0.19;M81.08,30.14c0.27,0.19,0.43,0.84,0.48,1.21c0.05,0.37,0,26.45-0.05,28.78;M80.82,37.99C78.75,43.75,73.25,50.25,66,53.57;M81.39,38.41c2.11,3.34,8.11,11.09,11.75,13.64c0.77,0.54,1.21,0.97,1.86,1.16;[,M66.32,60.75c0.83,0.47,1.33,2.1,1.5,3.04c0.17,0.93,0.45,20.62,0.28,26.46;M68.17,74.72c5.98-0.42,12.15-1.4,18.44-1.69c1.46-0.07,1.83-0.14,2.75,0;M51.43,69.01c0.8,0.45,1.28,2.02,1.44,2.91c0.16,0.9,0.33,13.8,0.18,19.41;M37.41,91.61c0.74,0.21,2.73,0.69,4.71,0.64C53.01,92,74.04,90,89.77,89.97c1.99,0,5.43,0.43,6.56,0.64,;
鮨 M28.99,11.75c0.04,0.56,0.09,1.45-0.08,2.26c-1,4.76-8.77,17.21-16.67,23.61;M27.89,20.88c1.93,0,13.82-2.44,15.85-2.73c1.74-0.25,2.13,2.17,1.41,3.4,c-3.05,5.19-7.48,10.16-12.45,18.4;[,M16.2,41.65c0.23,0.48,0.74,1.31,0.87,1.91c1.05,4.92,2.17,18.27,2.83,27.37;M17.79,43.39c8.11-0.79,22.53-2.62,28.59-3.32c2.22-0.26,3.36,1.14,3.25,2.47,c-0.42,4.88-1.32,17.17-3.1,26.26;M31.4,42.79c0.92,0.66,1.62,2.68,1.65,4.25c0.13,6.94,0.04,16.75,0.04,20.18;M19.82,55.54c2.64-0.33,25.86-2.59,28.05-2.67;M20.31,68.6c5.84-0.21,18.53-1.73,26.6-2.15;[,M17.36,81.82c0,5.32-2.9,13.16-3.66,14.68;M24.28,77.58c1.63,2.98,3.18,11.16,3.58,15.79;M32.96,76.94c2.34,2.42,6.05,9.95,6.64,13.71;M42.55,74.62c3.33,2.65,8.61,10.91,9.45,15.03;[,M87.57,18.06c0.12,1.13,0.02,1.83-0.5,2.3c-5.42,4.92-14.93,9.6-26.27,12.43;M58.23,12.75c0.74,0.55,1.04,2.42,1.04,3.27c0,3.98-0.57,11.5-0.57,19.45c0,12.45,0.55,13.09,18.45,13.09,c17.28,0,17.6-3.06,17.6-11.11;[,M61.65,57.55c0.49,0.98,1.28,2.35,1.28,3.52c0,1.17,1.33,34.82,1.33,35.41;M63.26,59.69c2.09-0.14,23.25-2.47,25.15-2.64c1.59-0.14,2.61,1.58,2.49,2.43,c-0.25,1.72-0.67,35.14-0.67,36;M63.63,75.67c2.83,0,22.71-1.42,26.92-1.57;M64.41,93.44c6.39-0.16,17.67-0.83,25.63-0.97;
逡 M62.41,9.75c0.44,0.34,0.41,1.63,0.15,2.07c-3.24,5.47-11.8,11.96-16.24,16.89,c-1.43,1.59-1.88,1.65,0.88,1.22c8.56-1.33,24.19-3.84,33.6-5.34;M74.27,19.18c4.07,2.17,10.51,8.94,11.53,12.32;[,M55.81,32.78c0.04,0.35,0.18,0.92-0.08,1.39C54,37.3,49,43.32,42.2,47.46;M69.48,28.53c0.38,0.44,0.68,0.96,0.71,1.65c0.1,3.05-0.27,6-0.27,8.08c0,4.84,4.57,4.29,9.07,4.29,c4.75,0,7.7-0.59,8.54-1.79;[,M59.09,42.63c0.06,0.6-0.23,2.14-0.64,2.93c-2.88,5.63-8.41,14.71-19.17,22.59;M56.75,52.68c0.5,0.35,2.83,0.4,3.55,0.33c2.37-0.23,11.71-1.79,15.09-2.5,c2.32-0.49,3.15,0.61,2.39,1.89C72.25,61.56,55,76.99,39.17,82;M51.31,57.6C56,61,74,76.5,83.8,81.8c1.95,1.06,3.43,1.71,5.28,2.06;[,M16.46,13.75c4.6,1.52,11.89,6.26,13.04,8.63;M12.96,33.25c4.34,1.57,11.21,6.45,12.29,8.88;M10.5,56.11c2.25,0.9,3.75,0.45,4.75,0.22c1-0.22,8-3.14,9.5-3.59c1.5-0.45,3.75,1.12,2.75,2.47,c-1,1.35-4,6.5-4.75,7.63c-0.75,1.12-0.5,3.14,1,4.71c1.5,1.57,2.75,3.36,3.5,4.71C28,73.6,28,74.73,26.5,75.85,c-1.5,1.12-9,7.4-10.5,7.85;M11.75,84.63c3.06-0.5,9.17-1.73,13.76-0.74c4.59,0.99,30.65,7.62,35.16,8.9,c12.23,3.46,21.66,4.45,30.83,2.72;
可 M13.88,21.98C18,22.75,21.74,22.34,25.39,22c13.57-1.26,43.04-4.34,58.11-5.52,c3.93-0.31,7.74-0.5,11.63,0.33;[,M25,42.14c0.87,0.87,1.5,1.99,1.79,3.21c0.74,3.14,1.96,9.62,2.94,15.63c0.28,1.74,0.55,3.45,0.77,5.02;M27.38,44.28c7.5-1.77,16.49-3.18,21.87-4.27c3.75-0.76,5.13,1.05,4.31,4.53,c-1.01,4.33-1.94,8.21-3.4,14.01;M31.2,61.83c5.62-0.7,11.39-1.52,17.83-2.29c1.21-0.14,2.43-0.29,3.69-0.43;M75.46,20.33c1.04,1.04,2.01,2.67,2.01,4.77c0,14.56-0.01,60.44-0.01,65.4c0,10.62-7.96,1.25-9.46,0;
它 M51.53,10.49c1.17,0.38,2.84,2.25,2.81,3.35c-0.09,3.46-0.09,9.35-0.09,12.5;M22.4,28.37c0,4.05-3.7,15.19-5.39,17.89;M24.04,29.85c8.71-0.1,53.21-5.6,61.32-5.35c10.71,0.32,2.27,6.36-0.4,8.24;[,M77.47,46.06c0.03,0.94-0.58,2.19-1.25,2.86C71.89,53.23,57.51,65.09,43.5,69.5;M41.5,37.75c1.07,1.19,1.15,1.99,1.51,3.57c0.36,1.59-0.14,41.16-0.14,46.14,c0,12.79,13.39,10.79,25.64,10.79c9.5,0,16.42-0.67,20-4.25s3.14-7.73,3.5-11.3;
参 M50.93,9c0.19,0.75,0,2.05-0.39,2.49c-5.79,6.39-13.29,12.01-19.28,16.45c-2.11,1.56-1.69,3.23,1.53,2.64,C44.12,28.5,58.88,25.75,69,23.75;M62.75,17.8c4.09,2.01,10.57,8.28,11.59,11.42;[,M14.07,45.9c2.59,0.65,5.97,0.62,7.86,0.38C39.88,43.98,63,42.19,80.56,41.2,c2.35-0.13,6.03,0.08,8.62,0.67;M48.12,31.88c0.48,1.07,0.64,1.98,0.3,3.16C43.38,52.5,28.38,65.62,13.75,74.08;M55.34,43.36c6.71,6.04,20.28,19.26,28.7,25.57c2.32,1.74,4.46,3.32,7.46,4.19;[,M54.35,53.75c0.06,0.4-0.27,1.34-0.6,1.87c-2.2,3.45-8.73,10.76-20.51,14.89;M61.09,66.14c0.07,0.35-0.24,1.21-0.63,1.66c-2.66,3.1-10.96,10.14-24.34,13.57;M69.15,76c0.11,0.54-0.26,1.38-0.72,2.16C65.71,82.7,50.09,92.65,28.7,98.75;
筵 M29.49,9.75c0.05,0.58,0.1,1.49-0.09,2.32c-1.14,4.89-7.69,15.61-16.65,22.18;M27.73,22.29c3.71,0,18.61-2.29,22.77-2.29;M33.02,23.83c2.66,1.79,6.88,7.35,7.54,10.13;[,M61.98,9.5c0.04,0.52,0.16,1.35-0.07,2.08c-1.7,5.45-6.42,13.22-12.66,19.92;M62.98,18.85c4.49,0,22.36-2.72,27.4-2.72;M74,21.75c0.03,0.26,0.06,0.67-0.06,1.04c-0.7,2.19-4.71,7.01-10.2,9.96;[,M81.26,31.25c0.09,0.35,0.36,1-0.19,1.4c-6.8,4.9-16.85,9.4-34.57,13.35;[,M66.06,44.96c0.19,0.31,1.34,2.89,1.34,3.51c0,3.03,0,28.19-0.04,32.06;M68.95,59.02c5.28-0.24,10.33-0.79,15.88-0.95c1.29-0.04,1.62-0.08,2.42,0;M49.03,55.16c0.84,0.33,1.31,1.4,1.46,2.01c0.15,0.61-0.26,17.38-0.26,18.53c0,1.8,2.25,4.58,5.6,4.74,C67.25,81,74.25,80.5,86,79.5c1.7-0.14,4.17-0.14,5.14,0.04;[,M16.25,44.01c1.01,0.61,2.62,1.02,4.03,0.61c1.41-0.41,8.76-2.75,11.58-3.57,c2.82-0.82,2.88,0.92,2.01,2.1c-1.61,2.19-8.66,16.17-11.48,21.07;M22.73,63.97c3.51-0.72,10.54-3.29,12.94-3.47c2.4-0.18,4.71-0.58,3.88,2.57,C36.25,75.5,29.25,89,14.25,98.85;M16.5,74.09c6.01-0.16,33.25,17.66,65.9,23.13c4.02,0.67,8.08,1.01,11.1,1.28;
叩 M13.75,29.79c0.47,0.51,0.94,0.94,1.15,1.58c1.62,5.07,4.05,18.54,5.16,27.63;M16.65,31.22c11.77-2.22,19.79-3.56,25.25-4.23c2-0.24,3.19,1.44,2.91,2.87,c-1.18,5.92-2.56,15.07-4.32,23.25;M19.78,56.55c6.41-0.75,14.15-1.55,22.96-2.71;[,M48.75,17.25c1,0.25,2.99,1.08,5,1C60,18,82.5,14.25,85,14s6.25-0.5,6.5,4.75,c0.12,2.51,0.25,34.5-1.75,49.5C88.26,79.43,80.25,69.5,79.5,69;M61.33,18.5c0.22,1,0,73.75-0.22,80;
癨 M53.91,11.13c0.7,0.36,2.18,2.66,2.32,3.37c0.14,0.71,0.07,3.3-0.07,7.74;[,M24.63,23.73c1.52,0.54,4.3,0.63,5.82,0.54c15.8-0.91,41.05-3.02,55.11-3.73,c2.53-0.13,4.05,0.26,5.31,0.53;M29.49,24.5c0,0.93,0,1.85-0.01,2.75c-0.18,35.17-4.03,48.9-16.68,66.97;[,M11.75,34.25c3.44,2.2,8.89,9.07,9.75,12.5;M9.17,62.57c1.44,0.61,1.88,0.43,3.15-0.31c5.11-3,8.06-4.92,11.93-7.51;[,M43.88,31.16c1.26,0.05,3.59,0.25,4.82,0.13c6.56-0.64,23.51-2.22,29.42-2.31,c1.72-0.03,2.21-0.12,3.8,0.09;M39.9,38.09c-0.21,3.98-2.1,8.38-3.5,12.4;M40.04,40.58c6.05-0.8,33.3-3.57,46.15-3.57c7.44,0,0.95,4.95-0.23,6.21;M61.63,32.9c0.74,1.07,1.07,1.77,1.08,2.82c0.01,0.38-0.22,18.04-0.22,19.07;M48.38,45.01c2.45,0.53,5.79,2.12,7.12,3;M45.93,51.23c2.52,0.67,6.41,3.13,7.79,4.25;M70.44,43.67c3.31,1.18,7.06,3.54,8.38,4.52;M71.92,51.67c2.46,0.92,5.82,3.7,7.16,5.24;[,M46.95,56.79c0.15,1.04-0.04,2.41-0.51,3.3c-3.01,5.7-6.83,10.52-13.73,17.46;M44.17,66.81c0.69,0.47,1.22,1.5,1.27,2.23c0.41,6.48-0.56,28.09-0.22,31.47;M68.82,56.97c0.04,0.35-0.01,0.81-0.12,1.11c-0.72,1.91-1.64,3.39-3.29,5.72;M44.24,66.95c8.02-0.61,41.04-2.89,44.48-3.22;M64.36,66.1c0.39,0.24,0.7,0.57,0.7,0.98c0,4.2,0.04,19.25-0.19,25.87;M46.31,75.92c7.57-0.5,36.69-1.98,39.94-2.25;M45.9,84.96c7.98-0.43,37.51-2.29,40.93-2.52;M45.4,94.86c8.02-0.61,42.71-2.28,46.15-2.61;
門 M17.39,14.97c0.94,0.94,1.26,2.28,1.26,4c0,0.77-0.18,49.78-0.18,69.28c0,3.3-0.04,4.11-0.07,4.97;M19.77,17.18c6.04-0.81,20.02-2.86,21.83-2.97c1.91-0.12,2.9,1.04,3,1.96,c0.11,1.07-1.17,15.69-1.78,22.84c-0.19,2.21-0.31,3.71-0.31,3.87;M20.06,30.18C27,29,36.5,27.75,42.46,27.02;M19.61,43.82c8.39-1.32,14.14-2.57,21.55-3.17;[,M61.96,13.47c0.89,1.19,0.92,2.64,0.91,4.04c-0.02,3.82-0.08,14.92-0.05,20.49,c0.01,1.84,0.03,3.07,0.06,3.25;M63.98,15.09c6.63-0.9,21.65-3.51,23.46-3.6c1.96-0.1,3.82,1.63,3.82,2.98c0,18.78-0.52,61.53-0.51,75.14,c0.01,11.13-5.24,3.63-9.49-0.12;M64.34,26.89c6.16-0.89,20.29-2.39,25.5-2.67;M64.13,39.63c8.99-1,15.87-1.63,25.9-2.47;
殷 M42.81,14.25c0.06,0.3-0.24,1.41-0.61,1.71c-4.95,4.04-9.71,7.65-20.45,11.08;M20.1,26.25c0.9,1,0.82,1.75,0.82,4.03c0,20.78,0.33,44.97-10.11,62.94;M21.69,31.75c1.89-0.09,22.55-2.15,24.28-2.26c1.44-0.09,2.25,1.26,2.25,2.51,c0,1.09-1.94,20.2-1.94,20.73;M22.03,41.36c2.56,0,20.57-1.91,23.47-1.91;M21.91,52.11c5.22-0.38,17.08-1.4,23.58-1.73;M22.75,65.9c1.75,0.6,3.36,0.31,3.89,0.21c4.86-0.86,14.34-2.49,16.73-2.89c1.55-0.26,1.98,1.17,1.9,3,c-0.23,4.82-5.17,21.02-7.58,24.3c-2.24,3.06-4.44,1.48-6.14-0.89;[,M61.42,16.85c0.33,0.9,0.48,1.82,0.45,2.84c-0.21,10.56-2.92,21.46-8.59,26.17;M62.35,18.78c3.4-0.03,12.8-1.84,14.39-2.4c2.38-0.84,3.07,1.27,2.83,3.12,c-0.48,3.62-1.71,10.25-1.71,13.87c0,5.01,0.69,8.64,8.53,8.64c9.36,0,9.53-1.51,9.53-9.36;[,M55.75,52.69c1.53,0.37,1.72,0.92,4.79,0.37c3.06-0.55,20.07-2.02,22.17-2.57,c2.1-0.55,3.81,2.14,2.87,4.06C78.22,69.54,62.5,87.25,46.5,94.17;M55.48,59.4C59.49,60.26,79.06,83.14,93,92.51c2.17,1.46,3.75,2.43,5.77,2.92;
葩 M15.17,23.83c3.33,0.67,7.13,0.57,8.43,0.46c11.9-0.96,46.9-4.46,60.62-4.53,c2.16-0.01,5.37,0.14,6.45,0.41;M35.17,12.33c1.08,0.42,2.35,1.7,2.5,2.5c1.08,5.92,1.33,11.92,2.17,16.5;M67,11.5c1,1,1.2,2.36,0.83,3.83c-1.12,4.5-2.54,9.92-4.17,15.67;[,M34.77,33.25c0.45,0.51,0.11,2.16-0.09,2.58c-1.47,3.09-5.56,7.9-10.5,11.42;[,M17.67,47.5c1.5,1,1.5,1.71,1.5,3.19c0,1.48,0.48,35.59,0.79,42.89;M19.89,50.39c2.19-0.18,18.84-3.26,20.83-3.57c1.26-0.2,2.78,0.21,2.77,2.52,c0,3.95-1.13,30.8-1.54,42.91;M21.17,68.33c4.45-0.39,17.75-1.5,21-1.5;M20.17,90.5c5.33-0.42,14.98-1.14,20.67-1.33;[,M55.17,40.17C67,38.5,79.98,36.69,86.17,36c2.26-0.25,3.69,1.99,3.5,3.5C89,44.83,87.83,56,86.33,63.33;M70.63,38.6c0.43,0.39,0.7,3.12,0.71,3.9c0.01,3.88,0,9.17-0.5,19.33;M56.23,64.09c3.64-0.43,25.78-2.5,29.94-2.93;M53.17,38c1.83,1,2.15,3.16,2.18,4.96c0.14,8.02-0.26,30.2-0.26,35.62c0,18.54-0.63,19.76,19.58,19.76,c23.69,0,19.75-8.66,19.93-12.09;
裁 M23.63,25.63c1.68,0.45,3.54,0.3,5.24,0.16c6.57-0.5,14.34-1.94,20.32-2.48,c1.62-0.14,2.87-0.12,3.68,0.01;M39.42,12.87c0.67,0.67,1.27,2.13,1.27,3.64c0,3.5,0.14,16.5,0.14,21.36;M13.13,40.73c3.12,1.11,7.15,0.64,10.37,0.23c19.02-2.41,44.54-6.14,60.62-7.21,c3.07-0.2,5.99-0.32,9.01,0.33;[,M39.85,44.5c0.7,0.7,1.22,2.12,1.22,3.58c0,2.76-0.11,3.67-0.11,6.28;M19,56.97c2.31,0.14,4.56,0.32,6.89,0.1c9.99-0.95,18.74-2.32,27.37-3.39c1.66-0.2,3.27-0.4,4.9,0.1;M36.77,58.82c0.07,0.59,0.16,1.67-0.38,2.38C32,67,26.5,73.38,13.29,82.97;M28.91,73.38c0.79,0.79,1.14,1.87,1.14,3.24c0,3.25-0.14,7.38-0.14,11.19c0,1.24,1.23,1.92,2.21,1.01,c3.38-3.08,7.25-7.58,10.94-10.52;M56.18,59.96c0.02,0.21,0.21,1.01,0.09,1.29c-0.73,1.73-3.02,4.21-6.76,7.66;M42.12,65.56c6.88,4.19,12.63,9.69,18.21,18.18;[,M56.75,9.5c1.56,1.84,2.23,3.35,2.53,7.31c2.59,33.44,11.84,61.69,30.64,77.86,c5.52,4.75,5.01,0.29,4.23-7.86;M82.97,44.64c0.4,1.48,0.33,3-0.17,4.76c-3.43,12.1-12.26,34.39-28,48.57;M74.25,15c3.18,1.85,8.27,6.08,9.75,9.25;
佰 M34,18c0.24,2.09-0.07,4.82-0.83,6.61C28.31,36.02,22.64,46.25,11.5,60.13;M27.31,41.01c1.19,1.49,1.26,3.4,1.32,5.74c0.31,13.79-1.03,40.6-0.59,48;[,M43.46,22.92c1.15,0.47,3.26,0.62,4.41,0.47c10.38-1.39,28.79-3.06,43.64-4.02,c1.91-0.12,3.07,0.22,4.03,0.46;[,M67.85,23.88c0.33,0.61,0.39,1.35,0.3,1.89c-0.47,3.14-4.53,11.64-8.22,15.85;[,M49.76,42.32c0.61,1.3,1.04,1.96,1.22,3.69c1.06,10.49,1.23,40.19,1.48,48.74;M51.34,44.39c3.44-0.22,30.89-3.68,34.02-3.94c2.61-0.22,4.29,1.45,4.08,2.74,c-0.41,2.6-1.45,36.44-1.77,50.29;M52.78,66.7C67,65.25,78.5,64,86.73,64.13;M53.47,91.87c11.28-0.87,23.28-1.62,33.89-1.64;
疝 M55.31,12.13c0.76,0.38,2.36,2.88,2.51,3.65c0.15,0.77,0.08,4.15-0.07,8.96;[,M25.63,26.33c1.6,0.44,4.54,0.51,6.14,0.44c16.67-0.73,40.67-3.66,55.5-4.24,c2.67-0.1,4.27,0.21,5.61,0.43;M31.99,27.5c0,1.1,0,2.18-0.01,3.25c-0.12,32.98-2.25,50.65-17.93,62.97;[,M13.75,38.5c3.79,1.81,9.8,7.44,10.75,10.25;M11.17,67.54c1.53,0.67,2.01,0.47,3.35-0.34c5.45-3.28,8.6-5.37,12.72-8.2;[,M60.74,36c0.76,0.47,2.51,2.75,2.51,4.49c0,0.96-0.1,43.76-0.25,49.68;M41.68,61.71c0.83,0.52,1.78,2.72,1.66,3.76c-0.55,4.63-1.55,13.25-3.19,24.51,c-0.34,2.35,0.71,3.83,2.74,3.25c6.57-1.91,35.07-4.22,45.47-4.51;M87.24,57.13c0.76,0.48,1.51,3.53,1.51,4.49C88.75,69,88.5,82,88.5,95.96;
渥 M18.51,16.62c4.23,1.58,10.93,6.5,11.99,8.97;M13.5,44c4.24,1.37,10.94,5.62,12,7.75;M15,90.43c1.88,0.45,3.12-0.1,4.09-1.76c2.81-4.84,4.86-10,7.41-16.17;[,M41.42,20.09c1.44,0.54,4.22,0.77,5.75,0.66c7.08-0.52,24.88-2.83,31.96-3.6,c3.76-0.41,5.1,1.12,4.81,3.2c-0.44,3.15-1.19,6.15-2.16,10.62;M46.34,35.43c3.24-0.14,22.11-2,32.17-2.88c2.76-0.24,4.86-0.41,5.78-0.45;M44.99,21.72c0.9,0.89,1.18,2.46,1.14,3.53c-1.11,31.83-4.39,46.5-14.94,62.8;[,M50.91,45.86c1.71,0.64,4.23,0.29,5.98,0.06c8.33-1.12,17.16-2.1,25.11-2.75,c2.01-0.16,4.03-0.45,6.01-0.01;[,M66.99,47.39c0.01,1.11-0.22,1.76-0.76,2.38c-3.61,4.11-6.48,6.73-10.68,9.72,c-1.75,1.25-1.64,3.6,0.83,3.01c6.74-1.62,15.87-3.5,25.57-5.91;M78.24,51.52c3.36,1.96,8.68,8.06,9.52,11.11;[,M47.85,76.12c2.13,0.68,4.9,0.25,7.05-0.02c8.04-1.02,18.98-1.85,27.36-2.45,c2.26-0.16,4.67-0.27,6.92,0.16;M66.43,64.27c0.96,0.96,1.18,2.11,1.18,3.59c0,5.77-0.11,19.75-0.11,21.4;M40.31,90.99c2.57,0.74,5.55,0.83,8.19,0.55c9.96-1.07,27.13-2.04,41.39-2.59,c2.92-0.11,6.36,0.17,8.7,0.78;
虻 M12.01,38.65c0.89,0.89,1.32,1.93,1.49,3.1c0.69,4.73,1.47,11.11,2.2,17.12,c0.19,1.54,0.37,3.07,0.55,4.53;M14.47,40.98c6.25-0.88,18.6-2.68,24.65-3.3c2.92-0.3,4.76,0.34,4.19,3.58,c-0.82,4.65-1.66,8.19-2.93,15.96;M17.26,61.43c4.84-0.64,13.12-1.82,20.24-2.74c1.87-0.24,3.65-0.46,5.28-0.65;M26.17,18.25c1.23,1.23,1.51,2.88,1.51,4.47c0,4.78,0.05,45.53,0.05,58.91;M12.82,88.27c1.35,1.35,2.72,1,4.19,0.24C22.43,85.69,39.02,77,41.62,75.38;M37.75,67c3.2,3.03,8.26,12.44,9.06,17.14;[,M70.29,17.11C71.46,18.29,72,20,72,21.75c0,5,0,9.55,0,12.75;M51.13,37.71c1.99,0.79,4.65,0.66,6.99,0.29c9.09-1.42,24.09-3.54,31.91-4,c1.81-0.11,4.46-0.12,6.08,0.34;M53.72,39c0.95,0.95,1.26,2.12,1.26,4.1c0,11.4,0,31.46,0,35.78c0,10.87,0.02,11.22,19.89,11.22,c9.12,0,17,0.27,21.9-1.87;
貊 M37.39,14.5c0.07,0.46,0.28,1.34-0.14,1.87C31.96,22.92,21.25,31,11.4,34.73;M15.56,36.23c2.81,1.66,7.25,6.84,7.95,9.42;M28.49,27.92c2.29,1.35,5.9,5.54,6.47,7.64;M41.66,29.01c0.08,0.63,0.33,1.81-0.17,2.52c-6.22,8.84-15.42,16.95-31.64,24.08;M30.25,43.92C40,51.25,45,72.25,38.07,90.49c-3.95,10.41-8.84,0.94-9.98,0.05;M33.11,51.17c0.06,0.46,0.28,1.28-0.12,1.87C29.75,57.75,21,66.25,11.55,70.91;M37.39,61.64c0.07,0.59,0.3,1.6-0.14,2.37c-3.27,5.67-12.14,15.18-24.76,22.68;[,M45.46,20.81c1.58,0.64,4.49,0.83,6.08,0.64c13.6-1.57,19-1.83,39.46-3.16c2.64-0.17,4.23,0.31,5.55,0.63,;[,M71.34,22.88c0.34,0.57,0.4,1.26,0.31,1.75c-0.48,2.91-4.67,10.82-8.47,14.73;[,M53.26,41.32c0.61,1.3,1.22,1.96,1.22,3.69c0,15.99-0.02,41.99-0.02,51.24;M53.84,42.89c3.44-0.22,30.89-3.68,34.02-3.94c2.61-0.22,3.08,1.44,3.08,2.74,c0,9.31,0.05,39.44-0.27,53.29;M55.28,66.2C64,66,81.75,64,90.73,64.13;M54.97,93.37c11.28-0.87,25.28-1.62,35.39-2.14;
窗 M51.48,9.25c0.99,0.34,2.4,1.98,2.38,2.95c-0.07,3.05-0.07,4.74-0.08,7.52;M19,19.5c0,3.85-3.61,14.43-5.25,17;M18.87,23.74c12.8-1.99,58.5-5.99,67.84-5.88c12.09,0.14,2.56,7.41-0.45,9.3;[,M42.26,25.25c0.06,0.39,0.23,1.04-0.11,1.56c-3.17,4.8-9.81,10.33-20.15,14.94;M63.09,22.37c0.44,0.51,0.81,1.11,0.81,1.89c0,2.08-0.31,5.73-0.31,8.11c0,5.56,6.34,4.93,11.52,4.93,c5.46,0,10.15-0.72,10.91-1.12;[,M52.4,36.14c0.03,0.34,0.05,0.89-0.05,1.38c-0.63,2.91-4.23,9.29-9.15,13.19;[,M25,51.75c0.89,0.91,0.77,1.42,0.89,2.57c0.86,8.29,0.9,28.65,1.92,44.32;M26.52,53.91c13.68-1.77,44.54-3.89,53.87-4.17c3.86-0.11,4.87,2.07,4.6,4.69,c-1,9.82-1.68,27.5-3.67,42.57;[,M53.76,55.5c0.21,0.33,0.39,1.35,0.01,1.98C51.03,62,44.69,69.77,34.25,75;M53.75,61c1.1,0.22,2.79,1.19,3.62,1.11c4.13-0.36,8.86-0.49,12.52-1.44c2.63-0.68,3.77,0.76,2.77,2.03,C63.75,74,52.25,83.75,34.04,92.25;M40.89,66.89c7.63,2.8,19.7,11.51,21.61,15.86;M27.97,96.32c10.28,0,39.11-1.3,53.3-1.58;
完 M51.76,11.5c1.05,0.42,2.3,2,2.27,3.22c-0.08,3.82-0.08,6.83-0.08,10.31;M27,27.25c0,3.58-3.04,13.44-4.42,15.83;M27.6,29.35c8.9-1.6,47.15-5.53,53.31-5.56c9.85-0.04,1.22,7.34-1.86,9.35;[,M36.32,42.43c1.56,0.32,3.58,0.39,4.83,0.23c7.1-0.91,15.48-2.66,21.48-3.15,c2.08-0.17,3.36,0.11,4.41,0.23;M23.33,58.92c3.24,0.85,6.54,0.53,9.79,0.13c12.16-1.51,24.75-3.43,38.02-4.03,c3.36-0.15,6.69-0.31,10.03,0.21;[,M41.5,61.5c0.07,0.89,0.14,2.29-0.13,3.56c-1.61,7.51-10.08,25.44-23.45,34.1;M56.24,59.62c1.01,1.01,1.38,2.63,1.38,3.93c0,8.19-0.03,16.89-0.03,22.45c0,9.75,1.79,12.03,18.67,12.03,c16.25,0,17.64-2.03,17.64-12.62;
繚 M25.64,13.42c0.37,1.23,0.39,2.15-0.19,3.5c-2.55,5.93-6.77,12.75-11.75,17.49,c-0.69,0.66-0.74,2.85,0,3.09c3.94,1.23,6.97,2.86,10.35,5.12;M35.14,24.43c0.28,0.58,0.35,2.46,0,3.09c-5.46,9.73-14.08,22.18-21.61,30.44,c-1.72,1.89,0.43,2.98,1.55,2.59c4.71-1.61,14.88-4.49,20.93-6.03;M30.88,47.63c3.04,2.44,7.36,9.54,8.12,13.33;M25.21,60.62c0.06,0.36,0.8,1.85,0.85,4.09c0.27,10.79-0.18,30.79-0.18,34.46;M17.86,69.85c0.14,0.96,0.12,2.84-0.14,3.52C16,77.83,11.69,86.42,9.25,90.25;M33.25,69c3.34,3.66,5.9,12.16,6.67,15.47;[,M43.21,23.1c0.89,0.21,3.27,0.47,5.16,0.37c12.79-0.64,29.06-1.63,40.54-1.94,c1.97-0.05,3.56-0.03,5.34,0.14;M65.85,10.5c0.33,0.56,0.36,1.68,0.12,2.86c-3.04,14.93-9.5,28.87-22.22,37.89;M72.18,22.92c4.77,6.13,15.89,21.74,20.65,25.84c1.62,1.39,2.18,1.6,2.92,1.73;M43.77,32.83c2.57,1.26,6.65,5.18,7.29,7.13;M90.03,27.64c0.02,0.18,0.04,0.48-0.04,0.74c-0.51,1.56-3.43,4.99-7.43,7.08;[,M51.49,47.84c0.25,0.38,0.25,0.65,0.39,1.13c1.12,3.95,2.18,11.44,2.88,18.82;M52.16,48.37c7.87-0.91,20.82-2.4,26.69-3.17c2.16-0.28,3.76,2.21,3.65,3.21,c-0.41,3.65-1.36,11.61-2.35,17.71;M53.78,56.61c2.62-0.33,25.66-2.75,27.82-2.89;M55.17,66.01c5.63-0.43,17.3-1.75,25.08-2.46;[,M66.38,67.87c0.08,0.38,1.23,1.96,1.23,4.36c0,4.53,0.25,13.99,0.25,17.9c0,11.87-5.04,3.19-6.51,2.2;M53.76,74c0.04,0.44,0.08,1.14-0.07,1.77c-0.9,3.74-6.09,11.95-13.18,16.98;M78.46,74.12C83.15,77.1,90.58,86.37,91.75,91;"
i = 0
testc.split("\n").each do |line|
  c = SVG_Character.new(line)
  draw_to_file(c,i)
  i += 1
end
