import 'package:lingo_dragon/common/widgets/list_skeleton.dart';
import 'package:lingo_dragon/common/widgets/scaffold.dart';

import 'package:flutter/material.dart';

class TestListSkeleton extends StatefulWidget {
  const TestListSkeleton({Key? key}) : super(key: key);

  @override
  _TestListSkeletonState createState() => _TestListSkeletonState();
}

class _TestListSkeletonState extends State<TestListSkeleton> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("List Skeleton"),
        body: Container(
          child: ListSkeleton(line: 6),
        ));
  }
}
