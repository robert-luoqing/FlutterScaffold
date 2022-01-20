import '../../theme/text_style.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum SPBadgePattern { h14_f10 }

class SPBadge extends StatelessWidget {
  final SPBadgePattern pattern;
  final String badge;
  const SPBadge({required this.badge, required this.pattern, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (pattern) {
      case SPBadgePattern.h14_f10:
        return Center(
          child: SizedBox(
            height: 14,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7), color: Colors.red),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 14),
                child: Center(
                  child: Text(
                    badge,
                    style: SPTextStyle.text10cFFFStyle,
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }
}
