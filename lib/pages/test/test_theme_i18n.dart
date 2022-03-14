import '../../theme/dark_theme.dart';
import '../../theme/base_theme.dart';
import '../../providers/theme_provider.dart';
import '../../common/widgets/scaffold.dart';
import '../../providers/i18n_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestThemeAndI18N extends StatefulWidget {
  const TestThemeAndI18N({Key? key}) : super(key: key);

  @override
  _TestThemeAndI18NState createState() => _TestThemeAndI18NState();
}

class _TestThemeAndI18NState extends State<TestThemeAndI18N> {
  @override
  Widget build(BuildContext context) {
    return SPScaffold(
      title: const Text("Text Theme And I18N"),
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
                  child: const Text("Change Lang To EN")),
              ElevatedButton(
                  onPressed: () {
                    var localeProvider = context.read<SPI18NProvider>();
                    localeProvider
                        .changeLocale(localeProvider.supportedLocales[1]);
                  },
                  child: const Text("Change Lang To CN")),
              ElevatedButton(
                  onPressed: () {
                    var themeProvider = context.read<SPThemeProvider>();
                    themeProvider.changeTheme(BaseTheme());
                  },
                  child: const Text("Change Theme To Light")),
              ElevatedButton(
                  onPressed: () {
                    var themeProvider = context.read<SPThemeProvider>();
                    themeProvider.changeTheme(DarkTheme());
                  },
                  child: const Text("Change Theme To Dark")),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  SPI18N.of(context).helloWorld,
                  style: TextStyle(color: SPTheme.of(context).textColor),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
