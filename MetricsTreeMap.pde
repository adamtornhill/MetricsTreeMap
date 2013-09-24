// Copyright (C) 2013 Adam Tornhill
//
// Distributed under the GNU General Public License v3.0,
// see http://www.gnu.org/licenses/gpl.html
//
// This program generates a tree map of the given input.
// A tree map is basically an algorithm for visualizing the relative sizes 
// of its different items. The algorithm works by subdividing the 2D space 
// into smaller rectangles. The algorithm looks for a space-optimal layout (which 
// is a hard problem).
//
// I use this program to visualize different metrics from https://github.com/adamtornhill/code-maat
//
// The input is expected to be a CSV file with two columns:
//   1) The name of the module/entity, and 
//   2) The metric itself. The metric is used as weight in the tree map.
// All input has to be in the file metric_data.csv.
//
// The implementation is done in the Processing language with a 
// good ol' imperative coding style. Hope you find the program useful!
//
// Credits
// =======
// I've based the general structure on the code in 
// Visualizing Data: Exploring and Explaining Data with the Processing Environment by Ben Fry.
//
// The idea and technique to optimize the text font is from the book 
// Generative Design: Visualize, Program, and Create with Processing by
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, and Claudius Lazzeroni.
//
// Both of these are good books - recommended reads!

import java.util.Calendar;

import treemap.*;
Treemap map;

DynamicMapLayout layoutAlgorithm = new DynamicMapLayout();

int maxFontSize = 1000;
int minFontSize = 1;

PFont font;

void setup() {
  size(800,600);
   
  font = createFont("miso-bold.ttf", 10);
  smooth();

  MetricMapModel mapData = buildModelFromMetrics(ReadInputLines("metric_data.csv"));
  mapData.finishAdd();
  map = new Treemap(mapData, 0, 0, width, height);
}

String[] ReadInputLines(String csvFileName)
{
  return loadStrings(csvFileName);
}

void draw() {
  background(230);
  map.setLayout(layoutAlgorithm.current());
  map.updateLayout();
  map.draw();

  // Performance: tree maps are heavy => do not re-draw unless 
  // the user specifies an other option through keyboard input (see keyReleased). 
  noLoop();
}

void keyReleased() {
  if (layoutAlgorithm.specifyByKey(key)) {
    loop(); // re-draw using the new algorithm
  }
  
  if (key == 's') {
    saveFrame("map_" + timestamp() + ".png");
  }
}

MetricMapModel buildModelFromMetrics(String[] metricsAsLines) {
  MetricMapModel mapData = new MetricMapModel();
  
  for (int i=0; i < metricsAsLines.length; i++) {
    String [] chars=split(metricsAsLines[i],',');
    String name = chars[0];
    String revs = chars[1];
    
    String[] parts = split(name, "/");
    String shortName = parts[parts.length - 1];
    
    MetricItem metric = new MetricItem(shortName, int(revs));
    mapData.addMetric(metric);
  }
  
  return mapData;
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

















