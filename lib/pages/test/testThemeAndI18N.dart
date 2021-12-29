import '../../theme/darkTheme.dart';
import '../../theme/baseTheme.dart';
import '../../common/providers/themeProvider.dart';
import '../../common/controlls/scaffold.dart';
import '../../common/providers/i18nProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class TestThemeAndI18N extends StatefulWidget {
  const TestThemeAndI18N({Key? key}) : super(key: key);

  @override
  _TestThemeAndI18NState createState() => _TestThemeAndI18NState();
}

class _TestThemeAndI18NState extends State<TestThemeAndI18N> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      title: Text("Text Theme And I18N"),
      body: Container(
        color: SPTheme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    var localeProvider = context.read<SPI18NProvider>();
                    localeProvider
                        .changeLocale(localeProvider.supportedLocales[0]);
                  },
                  child: Text("Change Lang To EN")),
              ElevatedButton(
                  onPressed: () {
                    var localeProvider = context.read<SPI18NProvider>();
                    localeProvider
                        .changeLocale(localeProvider.supportedLocales[1]);
                  },
                  child: Text("Change Lang To CN")),
              ElevatedButton(
                  onPressed: () {
                    var themeProvider = context.read<SPThemeProvider>();
                    themeProvider.changeTheme(BaseTheme());
                  },
                  child: Text("Change Theme To Light")),
              ElevatedButton(
                  onPressed: () {
                    var themeProvider = context.read<SPThemeProvider>();
                    themeProvider.changeTheme(DarkTheme());
                  },
                  child: Text("Change Theme To Dark")),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  SPI18N.of(context).helloWorld,
                  style: TextStyle(color: SPTheme.of(context).textColor),
                ),
              )),
              TextField(
                  // textAlign: TextAlign.end,
                  decoration: InputDecoration.collapsed(hintText: 'hello')),
            ],
          ),
        ),
      ),
    );
  }
}
