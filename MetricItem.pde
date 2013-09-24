// Copyright (C) 2013 Adam Tornhill
//
// Distributed under the GNU General Public License v3.0,
// see http://www.gnu.org/licenses/gpl.html

// The metric items correspond to one line in the input.
// Each one of them gets represented as an rectangle in the map.
class MetricItem extends SimpleMapItem {
  private final String artifact;
  private final int TEXT_MARGIN = 3;

  public MetricItem(String artifact, int weight) {
    this.artifact = artifact;
    
    setSize(weight); // controls the relative size of this item's box
  }
  
  public String name() {
    return artifact;
  }

  public void draw() {
    drawAsRectangle();
    labelWithArtifactName();
  }
  
  private void drawAsRectangle() {
     strokeWeight(0.25);
     int alphaChannelReflectWeight = (int)getSize()*2;
     fill(255, 0, 0, alphaChannelReflectWeight);
     rect(x, y, w, h);
  }
  
  private void labelWithArtifactName() {
    calculateOptimalFontSize();
    
    fill(0);
    textAlign(CENTER, CENTER);
    text(artifact, x + w/2, y + h/2);
  }
  
  private void calculateOptimalFontSize() {
    // Increase the font until the text fills either the width or the height of 
    // our rectangular box:
    for (int i = minFontSize; i <= maxFontSize; i++) {
      textFont(font,i);
      if (optimumTextSize()) {
        break;
      }
    }
  }
  
  private boolean optimumTextSize() {
    final boolean fitsInWidth = w < textWidth(artifact) + TEXT_MARGIN;
    final boolean fitsInHeight = h < (textAscent()+textDescent()) + TEXT_MARGIN; 
    
    return fitsInWidth || fitsInHeight;
  }
}



