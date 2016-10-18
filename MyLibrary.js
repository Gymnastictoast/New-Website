//Creates an outlined text that is easy to read over any background 

function strokeText(message, x, y, mainCol, borderCol){
  fill(borderCol);
  text(message, x-2,y);
  text(message, x+2,y);
  text(message, x,y+2);
  text(message, x,y-2);
  fill(mainCol);
  text(message, x,y);
}