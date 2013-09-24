// Copyright (C) 2013 Adam Tornhill
//
// Distributed under the GNU General Public License v3.0,
// see http://www.gnu.org/licenses/gpl.html
class MetricMapModel extends SimpleMapModel {    
  private final Map<String, MetricItem> words = new HashMap<String, MetricItem>();

  public void addMetric(MetricItem metric) {
    words.put(metric.name(), metric);
  }

  public void finishAdd() {
    items = new MetricItem[words.size()];
    words.values().toArray(items);
  }
}



