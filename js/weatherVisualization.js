var weatherData;
var city = "Toronto";
var input;
var raindrops = [];
var cloud;

function setup() {
  createCanvas(600, 600);
  cloud = loadImage("images/cloud.png");
  input = createInput();
  loadJSON("http://api.openweathermap.org/data/2.5/weather?q=" + city + "&APPID=2ffe122d91a7b2a3048f838649fbf8eb&units=imperial", gotData);

  for(var i = 0; i < 100; i++){
  raindrops[i] = new raindrop();
  }
}

function raindrop(){
  this.x = random(width);
  this.y = random(height);
  this.speed = random(2);
  this.show = function(){
    fill(0,50,200);
    ellipse(this.x, this.y, 6, 6);
  },
  this.fall = function(){
    this.y += this.speed;
  },
  this.reset = function(){
    if(this.y >= height){
      this.y = 0;
  }
}
}
function gotData(data) {
  weatherData = data;
}


function draw() {



  if (weatherData) {
    input.changed(newCity);

    var r = map(weatherData.main.temp, 0, 100, 0, 255);
    var b = map(weatherData.main.temp, 0, 100, 255, 0);

    background(r, 150, b);

    if(weatherData.weather[0].main == "Clouds"){
      image(cloud, 70,95);
      image(cloud, 220,300);
    }

    if(weatherData.weather[0].main == "Rain"){
    for(var i = 0; i < raindrops.length; i++){
    raindrops[i].show();
    raindrops[i].fall();
    raindrops[i].reset();
    }
  }

    textSize(50);
    strokeText("It is currently " + weatherData.main.temp, 0, height / 2 - 50, 0, 255);
    strokeText(" degrees in " + city, 0, height / 2 + 50, 0, 255);
  }
}

function newCity() {
  city = input.value();
  loadJSON("http://api.openweathermap.org/data/2.5/weather?q=" + city + "&APPID=2ffe122d91a7b2a3048f838649fbf8eb&units=imperial", gotData);

}
