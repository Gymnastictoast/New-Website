/*
This sketch builds on a prior work, "Game Menu (Game not YET included)", created by Noah Hunt-Isaak
 http://studio.sketchpad.cc/sp/pad/view/ro.9o57z5Kl96xMT/rev.1569
 */

/* @pjs pauseOnBlur="true"; *///sketch only runs when on this window



int menu_choice = 1;                 // choice 1 = play,   choice 2 = contorls   choice 3 = level select
int levelSelect_choice = 1;          // Corresponds directly with highlighted level on Level Selection screen
int game_mode = 0;                   // mode 0 = main menu   mode 1 = playing   mode 2 = controls screen   mode 3 = level select  mode 4 = Death screen
int level = 1;                       // current level if playing
int max_level = 7;                   //used for level selet screen (only shows up to maxlevel)
int deathBy = 0;                     //Records what killed you for death screen    1 = green circle


////////////////////////////////////////////////////////////////////////
/*                                SETUP                               */
////////////////////////////////////////////////////////////////////////



void setup() {
  size(400, 400);
  stroke(255, 0, 0);
  smooth();
  textAlign(CENTER);                                 //Font and Text Settings
  PFont myFont = createFont("Harrington", 32);
  textFont(myFont);
  thumbsUp = loadImage("http://emojipedia-us.s3.amazonaws.com/cache/9b/91/9b91736b776daabcdeb6c83c2399d8d6.png");
}


////////////////////////////////////////////////////////////////////////
/*                                DRAW                                 */
////////////////////////////////////////////////////////////////////////

void draw() {


  if (game_mode == 0)
    mainMenu();

  else if (game_mode == 1) {
    Playing();

    if (level == 1)
      Level1();
    else if (level == 2)
      Level2();
    else if (level == 3)
      Level3();
    else if (level == 4)
      Level4();
    else if (level == 5)
      Level5();
    else if (level == 6)
      Level6();
    else if (level == 7)
      Won();
  } else if (game_mode == 2)
    Controls();

  else if (game_mode == 3)
    level_Select();

  else if (game_mode == 4)
    gameOver();


  if (focused == false) {
    background(0);
    text("Click on Screen", 200, 200);
  }
}


////////////////////////////////////////////////////////////////////////
/*                                MAIN MENU                           */
////////////////////////////////////////////////////////////////////////

void mainMenu() {

  //Uncomment below for a list of all available fonts
  //String[] fontList = PFont.list();
  //printArray(fontList);


  background(0);                           //Text for menu screen
  textSize(40);
  fill(255, 0, 0);
  text("Really Great Game", width/2, 100);
  text("Play", width/2, 170);
  text("Controls", width/2, 210);
  text("Level Select", width/2, 250);
  textSize(30);
  text("'Up' and 'Down' to Navigate", width/2, 330);
  text(" 'Enter' to Select", width/2, 370);
  textSize(15);
  text("Created by Noah Hunt-Isaak", 270, 30);
  textSize(40);

  if (menu_choice == 1)                         //Draw a line under current menu choice
    line(width/2-40, 174, width/2+40, 174);
  else if (menu_choice == 2)
    line(width/2-75, 214, width/2+80, 214);
  else if (menu_choice == 3)
    line(width/2-100, 254, width/2+100, 254);
}



float badguy1X = 100;
float x = 30;                          //keeps track of ball location and movement
float y = 40;
float diam = 30;
boolean moveRight = false;
boolean moveLeft = false;
boolean moveUp = false;
boolean onFloor = false;
float ySpeed = 0;
float gravity = .3;
float jumpHeight = 8;


////////////////////////////////////////////////////////////////////////
/*                                PLAYING                             */
////////////////////////////////////////////////////////////////////////

void Playing() {

  background(0);


  rect(0, 390, width, 10);  //every level has a floor

  text("Level  ", 70, 40);                  //Text while playing (menu button and level)
  text(level, 120, 40);
  text("Menu", 300, 40);
  if (mouseX > 200 && mouseX < (360) && mouseY>10 && mouseY<50) {
    noFill();
    rect(230, 8, 140, 40);
    if (mousePressed) {
      game_mode = 0;
    }
  }



  fill(40, 100, 200);
  ellipse(x, y, diam, diam);                     // PLAYER CONTROLLED BALL
  fill(255, 0, 0);

  if (x > width)                                 //If move over the edge, jump to the other side of the screen
    x = 0;
  if (x < 0)
    x = width;

  if (!onFloor)                            //Gravity affects you when not on the ground
    ySpeed = ySpeed - gravity;

  if (ySpeed < 0 & onFloor)             //So you don't fall through the floor
    ySpeed = 0;

  if (ySpeed <= -50)               //Sets Max ySpeed to avoid infinite portal problems
    ySpeed = -50;

  y = y - ySpeed;                  //Update y position with speed


  if (moveRight == true ) {           //booleans for move right,left and jump
    x = x + 5;
  }
  if (moveLeft == true) {
    x = x - 5;
  }
  if (moveUp == true) {
    ySpeed = -5;
  }
}



////////////////////////////////////////////////////////////////////////
/*                                KEY PRESSED                         */
////////////////////////////////////////////////////////////////////////

void keyPressed() {

  if (game_mode != 1) {          //Makes sure ball position and speed is reset whenever you return to menu
    x = 30;
    y = 350;
    ySpeed = 0;
    rectMode(CORNER);
  }

  //Level_Select Controls

  if (game_mode == 3) {
    if ((keyCode == RETURN || keyCode == ENTER) && levelSelect_choice == 1) {
      game_mode = 1;
      level = 1;
    }
    if ((keyCode == RETURN || keyCode == ENTER) && levelSelect_choice == 2) {
      game_mode = 1;
      x=30;
      y=350;
      level = 2;
    }
    if ((keyCode == RETURN || keyCode == ENTER) && levelSelect_choice == 3) {
      game_mode = 1;
      level = 3;
    }
    if ((keyCode == RETURN || keyCode == ENTER) && levelSelect_choice == 4) {
      game_mode = 1;
      level = 4;
    }
    if ((keyCode == RETURN || keyCode == ENTER) && levelSelect_choice == 5) {
      game_mode = 1;
      y = 275;
      level = 5;
    }
    if ((keyCode == RETURN || keyCode == ENTER) && levelSelect_choice == 6) {
      game_mode = 1;
      level = 6;
    }
    if ((keyCode == RETURN || keyCode == ENTER) && levelSelect_choice == 7) {
      game_mode = 1;
      level = 7;
    }
    if ((keyCode == RETURN || keyCode == ENTER) && levelSelect_choice == 8) {
      game_mode = 1;
      level = 8;
    }



    if (keyCode == DOWN) {
      levelSelect_choice = levelSelect_choice +1;
      if (levelSelect_choice > max_level)
        levelSelect_choice = 1;
    }
    if (keyCode == UP) {
      levelSelect_choice = levelSelect_choice -1;
      if (levelSelect_choice < 1)
        levelSelect_choice = max_level;
    }
  }

  //Menu Controls

  if (game_mode == 0) {
    if ((keyCode == RETURN || keyCode == ENTER) && menu_choice == 1) {
      game_mode = 1;
    }
    if ((keyCode == RETURN || keyCode == ENTER) && menu_choice == 2) {
      game_mode = 2;
    }
    if ((keyCode == RETURN || keyCode == ENTER) && menu_choice == 3) {
      game_mode = 3;
    }
    if (keyCode == DOWN) {
      menu_choice = menu_choice + 1;
      if (menu_choice >= 4) {
        menu_choice = 1;
      }
    }
    if (keyCode == UP) {
      menu_choice = menu_choice - 1;
      if (menu_choice < 1) {
        menu_choice = 3;
      }
    }
  }

  //Playing Controls

  if (game_mode == 1) {
    if (keyCode == RIGHT)                  //Using booleans with key pressed and released for lateral movement allows for diagonal movement
      moveRight = true;                     //as well as avoiding the slight pause between the 1st and sequential key presses

    if (keyCode == LEFT)
      moveLeft = true;

    if (keyCode == UP && onFloor)
      ySpeed = jumpHeight;
  }



}

void keyReleased() {

  if (game_mode == 1) {
    if (keyCode == RIGHT)
      moveRight = false;

    if (keyCode == LEFT)
      moveLeft = false;
  }
}



////////////////////////////////////////////////////////////////////////
/*                                CONTROLS                            */
////////////////////////////////////////////////////////////////////////


void Controls() {

  background(0);                                 //Text (instructions) for controls screen
  rectMode(CENTER);
  text("-Arrow Keys to Move", width/2, 50);
  text("-Get to the ", 110, 110);
  text("To Win", 315, 110);
  text("-", 30, 170);
  text("Teleports you to", 225, 170);
  text("Another", 80, 215);
  text("of the Same", 300, 215);
  text("Color", 300, 265);

  fill(0, 255, 0);                        //draw portals for controls screen
  ellipse(60, 160, 40, 50);               //left green portal
  ellipse(175, 210, 40, 50);              //right green portal

  fill(#24B4FF);                          //draw door for controls screen
  rect(220, 100, 30, -50);
  fill(255, 0, 0);
  ellipse(230, 100, 7, 7);



  text("Menu", 130, 300);
  text("Button",130,340);               //menu button on controls screen
  if (mouseX > 20 && mouseX < (width/2 - 10) && mouseY>230 && mouseY<height-30) {
    noFill();
    rect(130, 300, 130, 90);
    if (mousePressed) {
      game_mode = 0;
    }
  }
}


////////////////////////////////////////////////////////////////////////
/*                                LEVEL SELECT                        */
////////////////////////////////////////////////////////////////////////


void level_Select() {

  background(0);
  rectMode(CENTER);
  textSize(20);
  text("Only 6 levels atm,",300,320);
  text("More coming soon",300,345);
  textSize(40);

  if (levelSelect_choice == 1)             //Selection lines for Level Select Screen
    line(35, 48, 180, 48);
  else if (levelSelect_choice == 2)
    line(35, 95, 180, 95);
  else if (levelSelect_choice == 3)
    line(35, 145, 180, 145);
  else if (levelSelect_choice == 4)
    line(35, 195, 180, 195);
  else if (levelSelect_choice == 5)
    line(35, 245, 180, 245);
  else if (levelSelect_choice == 6)
    line(35, 295, 180, 295);

  else if (levelSelect_choice == 7)
    line(235, 48, 380, 48);
  else if (levelSelect_choice == 8)
    line(235, 95, 380, 95);
  else if (levelSelect_choice == 9)
    line(235, 145, 380, 145);
  else if (levelSelect_choice == 10)
    line(235, 195, 380, 195);
  else if (levelSelect_choice == 11)
    line(235, 245, 380, 245);
  else if (levelSelect_choice == 12)
    line(235, 295, 380, 295);


  text("Menu", 80, 340);
  text("Button",85,375);                                                           //Menu button on Level Select Screen
  if (mouseX > 20 && mouseX < (width/2 - 50) && mouseY>230 && mouseY<height-30) {
    noFill();
    rect(90, 340, 130, 80);
    if (mousePressed)
      game_mode = 0;
  }


  text("Level " + 1, width/2-100, 35);            //Displays Levels up to Max Level as Options for Level Select Screen
  if (max_level >= 2)
    text("Level " + 2, width/2-100, 85);
  if (max_level >= 3)
    text("Level " + 3, width/2-100, 130);
  if (max_level >= 4)
    text("Level " + 4, width/2-100, 180);
  if (max_level >= 5)
    text("Level " + 5, width/2-100, 230);
  if (max_level >= 6)
    text("Level " + 6, width/2-100, 280);

  if (max_level >= 7)
    text("Level " + 7, width/2+100, 35);
   if (max_level >= 8)
    text("Level " + 8, width/2+100, 85);
  if (max_level >= 9)
    text("Level " + 9, width/2+100, 130);
  if (max_level >= 10)
    text("Level " + 10, width/2+100, 180);
  if (max_level >= 11)
    text("Level " + 11, width/2+100, 230);
  if (max_level >= 12)
    text("Level " + 12, width/2+100, 280);
}


////////////////////////////////////////////////////////////////////////
/*                                LEVEL 1                             */
////////////////////////////////////////////////////////////////////////

void Level1 () {


  text("<-----", 50, 320);  //arrow hint

  rect(265, 300, 100, 100);  //block right
  rect(160, 200, 110, 200);  //platform with door
  rect(262, 200, 10, 200);  //vertical wall

  Door door1 = new Door(180,200);
  door1.display();




  if ((y >=  390-diam/2)) {
    onFloor = true;
    y = 390-diam/2;
  } else if ((y >= 300-diam/2 && y < 300 && x > 265 && x<365)) {
    onFloor = true;
    y =300-diam/2;
  } else if ((x>155 && x<275 && y>=200-diam/2)) {
    onFloor = true;
    y = 200-diam/2;
  } else {
    onFloor = false;
  }

  if (x>=146 && x < 200 && y>200)    //can't walk through verticle wall from left
    x=146;

  if (x<287 && x > 256 && y>200) //can't walk through verticle wall from right
    x=288;

  if (x<380 && x > 356 && y>300) //can't walk through verticle wall from right
    x=381;
}


////////////////////////////////////////////////////////////////////////
/*                                LEVEL 2                             */
////////////////////////////////////////////////////////////////////////

void Level2() {


  rect(0, 200, 100, 10);  //plat left
  rect(100, 150, 10, 300); //wall left
  rect(300, 300, 100, 10);  //plat right

  textSize(20);
  text("Try Jumping Here",325,170);
  text("----->",330,190);



  Door door2 = new Door(70,200);
  door2.display();




  if ((x+diam/2>100) && (x+diam/2<110) && (y>210))  //left wall from left
    x=99-diam/2;

  if ((x-diam/2>100) && (x-diam/2<110) && (y>180))  //left wall from right
    x=110+diam/2;

  if (x>285 && y-diam/2<310 && y-diam/2>300) {    //cant jump from below plat on right onto plat
    y=310+diam/2;
    ySpeed = 0;
  }
  if (x<105 && y-diam/2<210 && y>205) {            //cant jump from below plat on left onto plat
    y=210+diam/2;
    ySpeed = 0;
  }
  if (y >=  390-diam/2) {    //cant fall through plats
    onFloor = true;
    y = 390-diam/2;
  } else if ((y>=300-diam/2 && y<300 && x>285)) {
    onFloor = true;
    y = 300-diam/2;
  } else if ((x<110 && y>=200-diam/2 && y<200)) {
    onFloor = true;
    y = 200-diam/2;
  } else {
    onFloor = false;
  }
}


////////////////////////////////////////////////////////////////////////
/*                                LEVEL 3                             */
////////////////////////////////////////////////////////////////////////

void Level3() {


  rect(140,100,100,10); //plat with door

  fill(0, 255, 0);
  ellipse(300, 345, 40, 50);  //bottom portal
  ellipse(300, 100, 40, 50);  //top portal
  fill(255, 0, 0);

  if (x > 280 && x < 320 && y > 320 && y < 370) {      //Portal functions
    y = 100;
  }


  Door door3 = new Door(170,100);
  door3.display();


  if ((y >=  390-diam/2)) {
    onFloor = true;
    y = 390-diam/2;
  } else if(x>130 && x<250 && y>=100-diam/2 && y<100){
      onFloor = true;
      y = 100-diam/2;
      }

  else {
    onFloor = false;
  }
}


////////////////////////////////////////////////////////////////////////
/*                                LEVEL 4                             */
////////////////////////////////////////////////////////////////////////

void Level4() {

  text("<---", 135, 335);

  rect(120, 100, 200, 10);   //plat with door
  rect(200, 110, 10, 300); //middle Wall


  if (x>200-diam/2 && x<200 && y>110)
    x=200-diam/2;
  if (x<210+diam/2 && x>210 && y>110)
    x=210+diam/2;

  fill(0, 255, 0);
  ellipse(70, 325, 40, 50);  //green portal bottom
  ellipse(150, 220, 40, 50);  //green portal top
  fill(100, 150, 230);
  ellipse(320, 220, 40, 50);   //blue portal bottom
  ellipse(300, 75, 40, 50);   //blue portal top
  fill(255, 0, 0);


  if (x>50 && x<90 && y>300 && y<350) {     //green portal bottom works
    y = 220;
    x = 150;
  }
  if (x>275 && x<325 && y>195 && y<245){  //blue portal works
    y = 75;
    x= 300;
}


  Door door4 = new Door(170,100);
  door4.display();



  if ((y >=  390-diam/2)) {                             //cant fall through floor or plats
    onFloor = true;
    y = 390-diam/2;
  } else if (x>120 && x<320 && y>=100-diam/2 && y-diam/2<110) {
    onFloor = true;
    y = 100-diam/2;
  } else {
    onFloor = false;
  }
}


////////////////////////////////////////////////////////////////////////
/*                                LEVEL 5                             */
////////////////////////////////////////////////////////////////////////

void Level5() {

  textSize(30);
  text("Don't hit the Green Circle", 200, 150);
  textSize(40);



  fill(50, 200, 0);                           //Enemy Yellow Circle
  ellipse(badguy1X, 375, diam, diam);
  badguy1X+= 3;

  if (badguy1X > width)
    badguy1X = 0;

  if (dist(x, y, badguy1X, 375)<=15) {       //game over hit yellow cirlce
    deathBy = 1;
    game_mode = 4;
  }
  fill(255, 0, 0);

  Door door5 = new Door(80,390);
  door5.display();



  rect(0, 300, 300, 10);   //starting platform
  rect(0, 150, 10, 150);    //starting wall left


  if(x<300 && y>310 && y<=310+diam/2){   //cant jump up through starting plat
      y = 310+diam/2;
      ySpeed = ySpeed + 0.01;
      }

  if (x<=10+diam/2 && y<300 && y>150)     //Wall on left
    x = 10+diam/2;


  //cant jump through starting plat

  if (y >=  390-diam/2) {                           //cant fall through floor or plats
    onFloor = true;
    y = 390-diam/2;
  } else if (x<300 && y>=300-diam/2 && y<300) {
    onFloor = true;
    y = 300-diam/2;
  } else {
    onFloor = false;
  }
}



////////////////////////////////////////////////////////////////////////
/*                                LEVEL 6                             */
////////////////////////////////////////////////////////////////////////

void Level6() {


  rect(140,100,100,10); //plat with door
  rect(235,110,10,-120); //Wall

  fill(0, 255, 0);
  ellipse(300, 345, 40, 50);  //bottom portal
  ellipse(300, 100, 40, 50);  //top portal
  fill(255, 0, 0);

  if (x > 280 && x < 320 && y > 320 && y < 370) {      //Portal functions
    y = 100;
  }


  Door door6 = new Door(170,100);
  door6.display();

  if(y<120 && x<245+diam/2 && x>240-diam/2)  //Wall from right works
      x = 245+diam/2;

  if(y<120 && x<245+diam/2 && x>235-diam/2)  //Wall from left works
      x = 235-diam/2;



  if ((y >=  390-diam/2)) {
    onFloor = true;
    y = 390-diam/2;
  } else if(x>130 && x<250 && y>=100-diam/2 && y<100){
      onFloor = true;
      y = 100-diam/2;
      }

  else {
    onFloor = false;
  }
}




////////////////////////////////////////////////////////////////////////
/*                                GAME OVER                           */
////////////////////////////////////////////////////////////////////////g


void gameOver() {


  background(0);
  text("Oh No!", 200, 150);
  text("Try Again?", 200, 300);
  text("Menu", 300, 40);

  if (deathBy == 1) {
    fill(50, 200, 0);
    ellipse(110, 180, 30, 30);
    fill(255, 0, 0);
    text("Killed You", 230, 200);
  }
  if (mouseX > 200 && mouseX < (360) && mouseY>10 && mouseY<50) {
    noFill();

    rect(230, 8, 140, 40);
    if (mousePressed) {
      game_mode = 0;
    }
  }

  if (mouseX>95 && mouseX<305 && mouseY>250 && mouseY<330) {
    noFill();
    rect(90, 250, 250, 80);
    if (mousePressed) {
      game_mode = 1;
      x = 30;                 //Reset position and speed when you die
      y = 275;
      badguy1X = 100;
      moveRight = false;
      moveLeft = false;
      moveUp = false;
      ySpeed = 0;
    }
  }
}




////////////////////////////////////////////////////////////////////////
/*                                WON                                 */
////////////////////////////////////////////////////////////////////////


void Won() {
    background(0);
    text("Well Done, You Won!",250,200);
    text("Menu", 300, 40);
    text("More Levels Coming Soon",250,320);


    image(thumbsUp,50,50);

    if (mouseX > 200 && mouseX < (360) && mouseY>10 && mouseY<50) {    //menu button
    noFill();
    rect(230, 8, 140, 40);
    if (mousePressed) {
      game_mode = 0;
    }
  }
}


////////////////////////////////////////////////////////////////////////
/*                                DOOR CLASS                          */
////////////////////////////////////////////////////////////////////////


class Door{

    float xloc;
    float yloc;

    Door(float doorx,float doory){
        xloc = doorx;
        yloc = doory;

        }

    void display(){
        fill(#24B4FF);
        rect(xloc, yloc, 30, -50);
        fill(255, 0, 0);
        ellipse(xloc + 25, yloc-20, 7, 7);

        if (x > xloc && x<xloc+30 && y>yloc-30 && y<yloc+20) {
           level += 1;
           if (max_level <= level) {
              max_level = level;
            }
            x = 30;
            y = 350;
          if(level == 5){
                y = 280;
                }
          }
       }
    }

    
////////////////////////////////////////////////////////////////////////
/*                                PLATFORM CLASS                      */
////////////////////////////////////////////////////////////////////////

/*

// NOTE  - -Platform class not currently working as intended

class Platform {

    float xloc;
    float yloc;
    float platwidth;
    float platheight;

    Platform(float platx,float platy,float pwidth,float pheight){
        xloc = platx;
        yloc = platy;
        platwidth = pwidth;
        platheight = pheight;


        }

    void display() {
        rect(xloc,yloc,platwidth,platheight);

        }

    boolean onPlat() {
        if(x >= xloc && x <= xloc + platwidth && y <= yloc && y >= yloc-(diam/2)){
            return true;
        } else {
            return false;}
        }
    }
*/
