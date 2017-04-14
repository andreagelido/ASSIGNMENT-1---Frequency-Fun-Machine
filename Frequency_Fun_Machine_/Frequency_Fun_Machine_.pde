import beads.*;
import java.util.Arrays; 

AudioContext ac;
WavePlayer sineWave;
WavePlayer sawWave;
WavePlayer squareWave;
WavePlayer triangleWave;

Boolean bDrawShape = false;
Boolean bBackgroundcolor = false;

void setup() {
  size(700, 700);
  ac = new AudioContext();

  // OSCILLATORS

  sineWave = new WavePlayer(ac, 20, Buffer.SINE);
  sawWave = new WavePlayer(ac, 32, Buffer.SAW);
  squareWave = new WavePlayer(ac, 32, Buffer.SQUARE);
  triangleWave = new WavePlayer(ac, 32, Buffer.TRIANGLE);


  sawWave.pause(true);
  squareWave.pause(true);
  triangleWave.pause(true);

  Gain g = new Gain(ac, 1, 0.1);
  g.addInput(sineWave);
  g.addInput(sawWave);
  g.addInput(squareWave);
  g.addInput(triangleWave);
  ac.out.addInput(g);
  ac.start();
}

void draw() {

  //scan across the pixels
  float volume = ac.out.getValue(0, 0);
  float phaseSine = sineWave.getValue();
  sineWave.setFrequency(mouseX);
  sawWave.setFrequency(mouseY);
  squareWave.setFrequency(mouseY);
  triangleWave.setFrequency(mouseY);


  // BACKGROUND COLOUR

  if (bBackgroundcolor == true) {
    float r = map(volume, -0.15, 0.15, 0, 255);
    background(r, 0, 0);
  } else {
    background(map(volume, -0.15, 0.15, 0, 255));
  } 

  // SHAPES

  float size = map(sawWave.getValue(), -1.0, 1.0, 0, 400);
  rectMode(CENTER);
  if (bDrawShape == true) {
    rect(width/2, height/2, size, size);
  }
}


// KEY PRESSED FUNCTIONS 

void keyPressed() {
  if (key == '1') {
    bDrawShape = true;
    sawWave.pause(false);
  }
  if (key == '2') {
    bDrawShape = false;
    sawWave.pause(true);
  }
  if (key == '3') {
    bBackgroundcolor = false;
  }
  if (key == '4') {
    bBackgroundcolor = true;
  }

  if (key == '5') {
    squareWave.pause(false);
  }
  if (key == '6') {
    squareWave.pause(true);
  }  
  if (key == '7') {
    triangleWave.pause(false);
  } 
  if (key == '8') {
    triangleWave.pause(true);
  }
}