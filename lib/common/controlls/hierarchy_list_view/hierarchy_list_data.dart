class HierarchyListData {
  HierarchyListData(
      {this.data,
      this.hierarchyLevel = 0,
      this.parentData,
      this.mapListIndex = 0});

  dynamic data;
  int hierarchyLevel;
  dynamic parentData;
  int mapListIndex;
}
