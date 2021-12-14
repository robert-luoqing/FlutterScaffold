import '../../../common/utils/platformUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SPScaffold extends StatefulWidget {
  final Widget? body;
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool? noStatusBar;
  final Key? scaffoldKey;
  final bool resizeToAvoidBottomInset;
  // 这个只有在应用了safe area时才会有效（在Android上有效）
  final Color statusbarColor;

  ///
  /// 这个只给appbar用
  ///
  final double? leadingWidth;

  final bool applyBottomSafeArea;

  SPScaffold(
      {this.title,
      this.leading,
      this.actions,
      this.body,
      this.floatingActionButton,
      this.bottomNavigationBar,
      this.leadingWidth,
      this.noStatusBar,
      this.applyBottomSafeArea = true,
      this.scaffoldKey,
      this.resizeToAvoidBottomInset = false,
      this.statusbarColor = Colors.white});
  @override
  _SPScaffoldState createState() => _SPScaffoldState();
}

class _SPScaffoldState extends State<SPScaffold> {
  _buildIOSAppBar() {
    if (this.widget.noStatusBar == true) {
      return null;
    }

    return CupertinoNavigationBar(
      middle: this.widget.title,
      leading: this.widget.leading,
      trailing: this.widget.actions == null
          ? null
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: this.widget.actions!),
    );
  }

  _buildAndriodAppBar() {
    if (this.widget.noStatusBar == true) {
      return null;
    }

    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      leadingWidth: this.widget.leadingWidth,
      centerTitle: true,
      title: this.widget.title,
      leading: this.widget.leading,
      actions: this.widget.actions,
    );
  }

  _buildAndroidScaffold() {
    Widget? content = this.widget.body;
    if (this.widget.noStatusBar != true ||
        this.widget.bottomNavigationBar != null) {
      content = Container(
          color: this.widget.statusbarColor,
          child: SafeArea(
              bottom: this.widget.applyBottomSafeArea,
              child: Container(child: this.widget.body)));
    }
    return Scaffold(
        resizeToAvoidBottomInset: this.widget.resizeToAvoidBottomInset,
        appBar: _buildAndriodAppBar(),
        key: this.widget.scaffoldKey,
        body: SizedBox(
            width: double.infinity, height: double.infinity, child: content),
        floatingActionButton: this.widget.floatingActionButton,
        bottomNavigationBar: this.widget.bottomNavigationBar);
  }

  _buildiOSScaffold() {
    Widget child;

    if (this.widget.floatingActionButton != null ||
        this.widget.bottomNavigationBar != null) {
      var children = <Widget>[];
      children.add(Positioned(
          child: this.widget.body ?? Container(),
          left: 0,
          right: 0,
          bottom: 0,
          top: 0));
      if (this.widget.floatingActionButton != null) {
        children.add(Positioned(
          child: this.widget.floatingActionButton!,
          bottom: 30,
          right: 30,
        ));
      }
      var mainChild = Stack(children: children);

      List<Widget> columnChildren = [];
      columnChildren.add(Expanded(child: mainChild, flex: 1));
      if (this.widget.bottomNavigationBar != null) {
        columnChildren.add(this.widget.bottomNavigationBar!);
      }

      child = Column(children: columnChildren);
    } else {
      child = this.widget.body ?? Container();
    }

    var appBar = _buildIOSAppBar();
    if (this.widget.bottomNavigationBar != null) {
      return CupertinoPageScaffold(
          resizeToAvoidBottomInset: this.widget.resizeToAvoidBottomInset,
          navigationBar: appBar,
          key: this.widget.scaffoldKey,
          child: SafeArea(bottom: false, child: Material(child: child)));
    } else {
      // noStatusBar
      Widget content = Container(
          child: Material(
              child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: child)));
      if (this.widget.noStatusBar != true) {
        content =
            SafeArea(bottom: this.widget.applyBottomSafeArea, child: content);
      }
      return CupertinoPageScaffold(
          resizeToAvoidBottomInset: this.widget.resizeToAvoidBottomInset,
          navigationBar: appBar,
          key: this.widget.scaffoldKey,
          child: content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SPPlatform.isIOS() ? _buildiOSScaffold() : _buildAndroidScaffold();
  }
}
