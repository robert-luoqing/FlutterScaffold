import '../../../common/utils/textStyleUtil.dart';
import 'package:flutter/material.dart';

enum SPButtonPattern {
  o_r12_h24_11_FB8934,
  g_h_r20_h40_13_E37B27,
  r_h22_11_FFF,
  r_h22_22_F4A323_F46921,
  r_h40_17_F4A323_F46921,
  r_h40_15_F4A323_F46921,
  r_h35_13_F4A323_F46921,
  r_h35_13_FFF,
  r_h35_13_F46921,
  normal,
  round_h24_12_FE8B3A,
  r_h28_13_1AFE9807_fF4904A,
  normal_h28_12_FE8B3A,
  r_h28_12_FE8B3A,
  normal_h21_8_FFF,
  normal_h21_10_FFF,
  normal_h40_17_F4A323_F46921,
  normal_h21_10_FFF_fF68B30,
  normal_h21_10_F4A323_F46921,
  normal_h40_15_F4A323_F46921,
  normal_h40_15_PFFF_fFA991D,
  normal_h44_15_F79300_fFFF,
  normal_h40_15_F46921,
  normal_h40_15_FFF
}

class SPButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final SPButtonPattern pattern;
  final String? text;
  final Widget? suffix;
  final Widget? icon;

  SPButton(
      {required this.pattern,
      required this.text,
      this.suffix,
      this.icon,
      this.onPressed});
  @override
  _SPButtonState createState() => _SPButtonState();
}

class _SPButtonState extends State<SPButton> {
  _didPress() {
    if (this.widget.onPressed != null) {
      this.widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (this.widget.pattern) {
      case SPButtonPattern.round_h24_12_FE8B3A:
        return ElevatedButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(24, 24)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.only(left: 10, right: 10)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(color: Color(0xFFFE8B3A)))),
              backgroundColor: MaterialStateProperty.all(Color(0xFFFE8B3A))),
          onPressed: _didPress,
          child: _renderContent(SPTextStyle.text12_FFF_BoldStyle),
        );
      case SPButtonPattern.r_h28_13_1AFE9807_fF4904A:
        return ElevatedButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(28, 28)),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.only(left: 10, right: 10)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      side: BorderSide(color: Color(0x1AFE9807)))),
              backgroundColor: MaterialStateProperty.all(Color(0x1AFE9807))),
          onPressed: _didPress,
          child: _renderContent(SPTextStyle.text13_F4904A_Style),
        );

      case SPButtonPattern.normal_h28_12_FE8B3A:
        return ElevatedButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(28, 28)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                        side: BorderSide(color: Color(0xFFFE8B3A)))),
                backgroundColor: MaterialStateProperty.all(Color(0xFFFE8B3A))),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text12_FFF_Style));
      case SPButtonPattern.r_h28_12_FE8B3A:
        return ElevatedButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(28, 28)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        side: BorderSide(color: Color(0xFFFE8B3A)))),
                backgroundColor: MaterialStateProperty.all(Color(0xFFFE8B3A))),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text12_FFF_Style));

      case SPButtonPattern.normal_h21_8_FFF:
        return ElevatedButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(24, 21)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFEEEEEE)))),
                backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF))),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text8_7D7_Style));
      case SPButtonPattern.normal_h21_10_FFF:
        return ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(24, 21)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFFEEEEEE)))),
              backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text10_7D7_Style));

      case SPButtonPattern.normal_h21_10_FFF_fF68B30:
        return ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(24, 21)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFFF68A31)))),
              backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text10_F68B30_Style));

      case SPButtonPattern.normal_h44_15_F79300_fFFF:
        return ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFFF79300)),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFFF79300)))),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text15_FFF_Style));

      case SPButtonPattern.r_h22_11_FFF:
        return ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(24, 22)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11.0),
                      side: BorderSide(color: Color(0xFF848484)))),
              backgroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text11_363_Style));

      case SPButtonPattern.r_h40_17_F4A323_F46921:
        return Container(
          height: 40,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFF4A323), Color(0xFFF46921)]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text17_FFF_Style),
          ),
        );

      case SPButtonPattern.r_h40_15_F4A323_F46921:
        return Container(
          height: 40,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFF4A323), Color(0xFFF46921)]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text15_FFF_Style),
          ),
        );

      case SPButtonPattern.r_h35_13_F4A323_F46921:
        return Container(
          height: 34,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFF4A323), Color(0xFFF46921)]),
            borderRadius: BorderRadius.circular(17),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17))),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text13_FFF_Style),
          ),
        );
      case SPButtonPattern.r_h35_13_F46921:
        return Container(
          height: 34,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFF46921), Color(0xFFF46921)]),
            borderRadius: BorderRadius.circular(17),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17))),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text13_FFF_Style),
          ),
        );
      case SPButtonPattern.r_h35_13_FFF:
        return Container(
          height: 35,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)]),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text13_999_Style),
          ),
        );

      case SPButtonPattern.r_h22_22_F4A323_F46921:
        return Container(
          height: 22,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFF4A323), Color(0xFFF46921)]),
            borderRadius: BorderRadius.circular(11),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(24, 22)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11))),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text11_FFF_Style),
          ),
        );

      case SPButtonPattern.normal_h40_17_F4A323_F46921:
        return Container(
          height: 40,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFF4A323), Color(0xFFF46921)]),
            borderRadius: BorderRadius.circular(0),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text17_FFF_Style),
          ),
        );

      case SPButtonPattern.normal_h40_15_F4A323_F46921:
        return Container(
          height: 40,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFF4A323), Color(0xFFF46921)]),
            borderRadius: BorderRadius.circular(0),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text15_FFF_Style),
          ),
        );
      case SPButtonPattern.normal_h40_15_F46921:
        return Container(
          height: 40,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFF46921), Color(0xFFF46921)]),
            borderRadius: BorderRadius.circular(0),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text15_FFF_Style),
          ),
        );
      case SPButtonPattern.normal_h40_15_FFF:
        return Container(
          height: 40,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)]),
            borderRadius: BorderRadius.circular(0),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text15_999_Style),
          ),
        );

      case SPButtonPattern.normal_h40_15_PFFF_fFA991D:
        return ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0))),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: _didPress,
          child: _renderContent(SPTextStyle.text15_FA991D_Style),
        );
      case SPButtonPattern.normal_h21_10_F4A323_F46921:
        return Container(
          height: 21,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFF4A323), Color(0xFFF46921)]),
            borderRadius: BorderRadius.circular(0),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(24, 21)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text10_FFF_Style),
          ),
        );

      case SPButtonPattern.o_r12_h24_11_FB8934:
        return ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(24, 24)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Color(0xFFFB8934)))),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: _didPress,
          child: _renderContent(SPTextStyle.text11_FB8934_Style),
        );
      case SPButtonPattern.g_h_r20_h40_13_E37B27:
        return Container(
          height: 40,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFE37B27), Color(0x00E37B27)]),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)))),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _didPress,
            child: _renderContent(SPTextStyle.text13_FFF_Style),
          ),
        );
      default:
        return ElevatedButton(
          onPressed: _didPress,
          child: Text(this.widget.text ?? ""),
        );
    }
  }

  _renderContent(TextStyle style) {
    if (this.widget.suffix == null && this.widget.icon == null) {
      return Text(
        this.widget.text ?? "",
        style: style,
      );
    } else {
      List<Widget> children = [];
      if (this.widget.icon != null) {
        children.add(this.widget.icon!);
      }
      children.add(Text(
        this.widget.text ?? "",
        style: style,
      ));
      if (this.widget.suffix != null) {
        children.add(this.widget.suffix!);
      }
      return Row(
          mainAxisAlignment: MainAxisAlignment.center, children: children);
    }
  }
}
