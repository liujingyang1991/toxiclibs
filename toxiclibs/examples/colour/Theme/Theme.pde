import processing.opengl.*;

/**
 * ColourTheme demo showing the following:
 * - construction of colour themes via textual descriptions of shades and colours
 * - adding an random element to the theme
 * - showing off different sort modes for the created ColourList
 *
 * Press SPACE to toggle rendering mode, any other key will re-generate a random variation of the colour theme
 *
 * @author Karsten Schmidt <info at postspectacular dot com>
 */

import java.util.Iterator;

import toxi.colour.*;
import toxi.geom.*;
import toxi.math.*;
import toxi.util.datatypes.*;

float   XRAD = 300;
float   YRAD = 500;
int     RES = 6;
int     NUM_POINTS=6;

void setup() {
  size(1024, 768);
  noiseDetail(2);
  smooth();
  noLoop();
}

void draw() {
  noiseSeed(System.currentTimeMillis());
  // first define our new theme
  ColourTheme t = new ColourTheme("test");
  // add different colour options, each with their own weight
  t.addRange("soft ivory", 0.5);
  t.addRange("intense goldenrod", 0.25);
  t.addRange("warm saddlebrown", 0.15);
  t.addRange("fresh teal", 0.05);
  t.addRange("bright yellowgreen", 0.05);

  // now add another random hue which is using only bright shades
  t.addRange(ColourRange.BRIGHT, Colour.newRandom(), random(0.02, 0.05));

  // use the colour theme to create a list of 160 colours
  ColourList list = t.getColors(160);

  background(list.getLightest().toARGB());
  drawSpline(list);
  //saveFrame("theme-"+(System.currentTimeMillis()/1000)+".png");
}

void keyPressed() {
  redraw();
}

void drawSpline(ColourList list) {
  noStroke();
  float numCols = list.size();
  Vec3D[] points=new Vec3D[NUM_POINTS];
  points[0]=new Vec3D(-XRAD,random(0.2,0.9)*height,0);
  for(int i=1; i<points.length-1; i++) {
    points[i]=new Vec3D(random(-1,1)*50+(float)i/points.length*width,random(0.25,0.75)*height,random(-1,1)*300);
  }
  points[points.length-1]=new Vec3D(width+XRAD,random(height),0);
  ArrayList vertices=new Spline3D(points).computeVertices(width/RES);
  for(Iterator i=vertices.iterator(); i.hasNext(); ) {
    Vec3D v=(Vec3D)i.next();
    fill(list.get((int) random(numCols)).toARGB());
    ellipse(v.x,v.y,noise(v.y*0.01)*XRAD,noise(v.x*0.01)*YRAD);
  }
}


