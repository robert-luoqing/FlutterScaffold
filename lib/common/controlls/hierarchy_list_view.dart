import 'package:flutter/material.dart';

/// The widget is used to wrap Hierarchy list
/// Like comment, reply comment etc.
/// comment1
///   reply1
///   reply2
///   <button>more</button>
///  comment2
///   reply21
///   reply22
///   ........
/// Click more, show progress and fetch more reply of comment1. 
/// Widget can control if the more button show up or collapse reply button show up etc.
class HierarchyListView extends StatefulWidget {
  const HierarchyListView({ Key? key }) : super(key: key);

  @override
  State<HierarchyListView> createState() => _HierarchyListViewState();
}

class _HierarchyListViewState extends State<HierarchyListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}