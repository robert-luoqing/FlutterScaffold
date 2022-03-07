class HierarchyListData {
  HierarchyListData(
      {this.type = HierarchyListDataType.data,
      this.data,
      this.hierarchyLevel = 0,
      this.parentData,
      this.mapListIndex = 0,
      this.indexInParent = 0,
      this.parentMapListIndex = 0});

  dynamic data;
  int hierarchyLevel;
  dynamic parentData;

  /// [mapListIndex] is actual index of list for the item
  int mapListIndex;
  HierarchyListDataType type;

  /// The index of item in parent
  int indexInParent;

  /// [parentMapListIndex] is index of list for the parent item
  /// It may invoke ensureVisisble() to make sure parent is visible
  int parentMapListIndex;
}

enum HierarchyListDataType { data, footer }
