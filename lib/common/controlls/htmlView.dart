import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

class SPHtmlView extends StatelessWidget {
  final String htmlData;
  const SPHtmlView({required this.htmlData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(data: htmlData);
  }
}
