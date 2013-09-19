import processing.serial.*;

PImage[] img;

int picAlpha = 255;
//variables
int nb_images=12;
int no_image=0;
 

 float Pot1 = 0;
 float Pot2 = 0;
 float Pot3 = 0;
 
Serial myPort;
 
 
void setup() {
   size(1280, 1024, P3D);
   
       img = new PImage[nb_images];
      for (int i=0; i<nb_images; i++) {
            img[i] = loadImage(i + ".jpg");
    noStroke();
    noCursor();
      }
      
 
   // List all the available serial ports
 println(Serial.list());
 // I know that the first port in the serial list on my mac
 // is always my Arduino, so I open Serial.list()[0].
 // Open whatever port is the one you're using.
 myPort = new Serial(this, Serial.list()[1], 9600);
 // don't generate a serialEvent() unless you get a newline character:
 myPort.bufferUntil('\n');
 
 
}
 
void draw() {
  
/*
 picAlpha = int(map(mouseX, 0, width, 0, 255));
*/
background(img[no_image]); 
image(img[no_image+1], 0, 0);
tint(255, Pot1);


}



 
 void serialEvent(Serial myPort) {
 // get the ASCII string:
 String inString = myPort.readStringUntil('\n');
 
 if (inString != null) {
 // trim off any whitespace:
 inString = trim(inString);
 // split the string on the commas and convert the
 // resulting substrings into an integer array:
 float[] potvalue = float(split(inString, ","));
 // if the array has at least three elements, you know
 // you got the whole thing. Put the numbers in the
 // potvalue variables:
 if (potvalue.length >=3) {
 // map them to the range 0-255:
 Pot1 = map(potvalue[0], 0, 1023, 0, 255);
 Pot2 = map(potvalue[1], 0, 1023, 0, 255);
 Pot3 = map(potvalue[2], 0, 1023, 0, 255);
 }
}
}

  void keyReleased() {
//                println(no_image);

  if (keyCode == 39) {
     if (no_image==nb_images-2)
  {
    no_image = 0; 
  }
  else
  {
    no_image = no_image + 2; 
    }
  }
if (keyCode == 37) {
     if (no_image==0)
  {
    no_image = nb_images-2; 
  }
  else
  {
    no_image = no_image - 2;
    }
  }

} 

/*
void mouseDragged() {
if (height - 50 < mouseY) {
picAlpha = int(map(mouseX, 0, width, 0, 255));
}
}*/
