var canvas;
var bubbles = [];
var applyWindRight = false;
var applyWindLeft = false;

function setup(){
  canvas = createCanvas(windowWidth-400,windowHeight-100);
  canvas.position(350,100);
  fill(100,200,255);
  for(var i = 0; i < 100; i++){
    bubbles[i] = new Bubble();
  }
}

function draw(){
  background(255);
  rect(0,0,width,10);
  rect(width-10,0,10,height);
  rect(0,0,10,height);
  rect(0,height-10,width,10);
  if(applyWindRight == true){
    text("WIND",20,55);
    line(50,50,100,50);
    line(100,50,75,70);
    line(100,50,75,30);
  } else if (applyWindLeft == true) {
    text("WIND",100,55);
    line(50,50,100,50);
    line(50,50,75,70);
    line(50,50,75,30);
  } else {
    text("Press Spacebar for wind!",20,55);
  }
  text("Press R to Reset xSpeeds", 20,95);
  for(var i = 0; i < bubbles.length; i++){
    bubbles[i].show();
    bubbles[i].applyGravity();
    bubbles[i].checkEdges();
    if(applyWindRight == true || applyWindLeft == true){
      bubbles[i].applyWind();
    }
  }
}

function Bubble(){
  this.x = random(15,width-15);
  this.y = random(15,height-30);
  this.diam = random(3,10);
  this.ySpeed = 0;
  this.xSpeed = 0;
  this.gravity = 0.08;
  this.wind = 0.08;

  this.show = function(){
    ellipse(this.x,this.y,this.diam,this.diam)
    this.y += this.ySpeed;
    this.x += this.xSpeed;

  },

  this.applyGravity = function(){
    this.ySpeed += this.gravity;
  },

  this.applyWind = function(){
    if(applyWindRight == true){
    this.xSpeed += this.wind;
  } else {
    this.xSpeed -= this.wind;
  }
},

  this.resetxSpeed = function(){
    this.xSpeed = 0;
  }

  this.checkEdges = function(){
    if(this.y >= (height-10)){
      this.ySpeed = -this.ySpeed;
      this.y = height-11;
    }
    if(this.y <= (10)){
      this.ySpeed = -this.ySpeed;
      this.y = 11;
    }
    if(this.x >= (width-10)){
      this.xSpeed = -this.xSpeed;
      this.x = width-11;
    }
    if(this.x <= (10)){
      this.xSpeed = -this.xSpeed;
      this.x = 11;
    }
  }
}

function keyPressed(){
  if(key == "r" || key == "R"){
    for(var i = 0; i < bubbles.length; i++){
      bubbles[i].resetxSpeed();
    }
  }
  if(key == " "){
  if(applyWindRight == true){
  applyWindRight = false;
  applyWindLeft = true;
} else if (applyWindLeft == true){
  applyWindLeft = false;
} else {
  applyWindRight = true;
}
}
}
