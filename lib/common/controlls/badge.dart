import '../../../common/utils/textStyleUtil.dart';
import 'package:flutter/material.dart';

enum SPBadgePattern { h14_f10 }

class SPBadge extends StatelessWidget {
  final SPBadgePattern pattern;
  final String badge;
  const SPBadge({required this.badge, required this.pattern, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (this.pattern) {
      case SPBadgePattern.h14_f10:
        return Center(
          child: SizedBox(
            height: 14,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7), color: Colors.red),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 14),
                child: Center(
                  child: Text(
                    this.badge,
                    style: SPTextStyle.text10_FFF_Style,
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }
}
