var weatherData;
var city = "Anchorage";
var input;
var raindrops = [];
var cloud;
var canvas;

function setup() {
    canvas = createCanvas(windowWidth - 400, windowHeight - 100);
    canvas.position(350, 100);
    cloud = loadImage("images/cloud.png");
    clock = createP("" + hour() + " " + minute() + " " + second());
    clock.position(1220, 5);
    input = createInput();
    input.position(188, windowHeight - 258);
    loadJSON("http://api.openweathermap.org/data/2.5/weather?q=" + city + "&APPID=2ffe122d91a7b2a3048f838649fbf8eb&units=imperial", gotData, "jsonp");

    for (var i = 0; i < 100; i++) {
        raindrops[i] = new raindrop();
    }
}



function raindrop() {
    this.x = random(width);
    this.y = random(height);
    this.speed = random(2);
    this.show = function() {
            fill(0, 50, 200);
            ellipse(this.x, this.y, 6, 6);
        },
        this.fall = function() {
            this.y += this.speed;
        },
        this.reset = function() {
            if (this.y >= height) {
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

        var grassCol = map(weatherData.main.temp, 0, 100, 130, 200);
        var r = map(weatherData.main.temp, 0, 100, 0, 255);
        var b = map(weatherData.main.temp, 0, 100, 255, 0);

        background(r, 150, b);


        if (weatherData.weather[0].main == "Clouds") {
            image(cloud, 70, 20);
            image(cloud, 300, 70);
        }

        if (weatherData.weather[0].main == "Clear") {
            fill(255, 255, 10);
            ellipse(450, 100, 130, 130);
        }

        if (weatherData.weather[0].main == "Rain") {
            for (var i = 0; i < raindrops.length; i++) {
                raindrops[i].show();
                raindrops[i].fall();
                raindrops[i].reset();
            }
        }

        fill(100, grassCol, 100);
        rect(0, height - 130, width, 130);
        textSize(50);
        textAlign(CENTER);
        strokeText("It is currently " + weatherData.main.temp, width / 2, height / 2 - 50, 0, 255);
        strokeText(" degrees in " + city, width / 2, height / 2 + 50, 0, 255);

        rect(0, 0, width, 10);
        rect(width - 10, 0, 10, height);
        rect(0, 0, 10, height);
        rect(0, height - 10, width, 10);
        clock.html("" + hour() + " " + minute() + " " + second());
    }
}

function newCity() {
    city = input.value();
    loadJSON("http://api.openweathermap.org/data/2.5/weather?q=" + city + "&APPID=2ffe122d91a7b2a3048f838649fbf8eb&units=imperial", gotData, "jsonp");

}
