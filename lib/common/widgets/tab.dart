import 'package:flutter/material.dart';

class SPTab extends StatelessWidget {
  final String text;
  const SPTab({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(text: text);
  }
}
