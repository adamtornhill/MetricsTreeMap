// Copyright (C) 2013 Adam Tornhill
//
// Distributed under the GNU General Public License v3.0,
// see http://www.gnu.org/licenses/gpl.html
import treemap.*;
import java.util.*;

// We support a bunch of different layouts.
// This class just glues them together with a 
// simple selection API.
class DynamicMapLayout {
  private final MapLayout defaultLayout =  new SquarifiedLayout();
  private MapLayout currentLayout = defaultLayout;
  private final Map<Character, MapLayout> supportedLayouts = new HashMap<Character, MapLayout>();
 
  public DynamicMapLayout() {
    supportedLayouts.put('1', new SquarifiedLayout());
    supportedLayouts.put('2', new PivotBySplitSize());
    supportedLayouts.put('3', new SliceLayout());
    supportedLayouts.put('4', new OrderedTreemap());
    supportedLayouts.put('5', new StripTreemap());
  } 
  
  // Invoked by a key press.
  // Returns true when successfully set (= valid layout index).
  public boolean specifyByKey(char pressedKey) {
    // Error handling: silent fallback on the current layout 
    // in case of an invalid index.
    if (supportedLayouts.containsKey(pressedKey)) {
      currentLayout = supportedLayouts.get(pressedKey);
      return true;
    }
    
    return false;
  }
  
  public MapLayout current() {
    return currentLayout;
  }
}
