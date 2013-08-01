import processing.serial.*;
 
 float Pot1 = 0;
 float Pot2 = 0;
 float Pot3 = 0;
 
Serial myPort;
 
PImage img1, img2;
int picAlpha = 255;
 
void setup() {
   size(1280, 828, P3D);
 
  img1 = loadImage("auzat2_1.jpg");
  img2 = loadImage("auzat2_2.jpg");
  noStroke();
 
   // List all the available serial ports
 println(Serial.list());
 // I know that the first port in the serial list on my mac
 // is always my  Arduino, so I open Serial.list()[0].
 // Open whatever port is the one you're using.
 myPort = new Serial(this, Serial.list()[8], 9600);
 // don't generate a serialEvent() unless you get a newline character:
 myPort.bufferUntil('\n');
 
 
}
 
void draw() {
  
//  picAlpha = int(map(mouseX, 0, width, 0, 255));

background(img1);
 
image(img2, 0, 0);
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
 // you got the whole thing.  Put the numbers in the
 // potvalue variables:
 if (potvalue.length >=3) {
 // map them to the range 0-255:
 Pot1 = map(potvalue[0], 0, 1023, 0, 255);
 Pot2 = map(potvalue[1], 0, 1023, 0, 255);
 Pot3 = map(potvalue[2], 0, 1023, 0, 255);
 }
}
}

/*
void mouseDragged() {
  if (height - 50 < mouseY) {
    picAlpha = int(map(mouseX, 0, width, 0, 255));
  }
}*/
