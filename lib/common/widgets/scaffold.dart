import '../utils/platform_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  const SPScaffold(
      {Key? key,
      this.title,
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
      this.statusbarColor = Colors.white})
      : super(key: key);
  @override
  _SPScaffoldState createState() => _SPScaffoldState();
}

class _SPScaffoldState extends State<SPScaffold> {
  _buildIOSAppBar() {
    if (widget.noStatusBar == true) {
      return null;
    }

    return CupertinoNavigationBar(
      middle: widget.title,
      leading: widget.leading,
      trailing: widget.actions == null
          ? null
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: widget.actions!),
    );
  }

  _buildAndriodAppBar() {
    if (widget.noStatusBar == true) {
      return null;
    }

    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white, //change your color here
      ),
      leadingWidth: widget.leadingWidth,
      centerTitle: true,
      title: widget.title,
      leading: widget.leading,
      actions: widget.actions,
    );
  }

  _buildAndroidScaffold() {
    Widget? content = widget.body;
    if (widget.noStatusBar != true || widget.bottomNavigationBar != null) {
      content = Container(
          color: widget.statusbarColor,
          child: SafeArea(
              bottom: widget.applyBottomSafeArea,
              child: Container(child: widget.body)));
    }
    return Scaffold(
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        appBar: _buildAndriodAppBar(),
        key: widget.scaffoldKey,
        body: SizedBox(
            width: double.infinity, height: double.infinity, child: content),
        floatingActionButton: widget.floatingActionButton,
        bottomNavigationBar: widget.bottomNavigationBar);
  }

  _buildiOSScaffold() {
    Widget child;

    if (widget.floatingActionButton != null ||
        widget.bottomNavigationBar != null) {
      var children = <Widget>[];
      children.add(Positioned(
          child: widget.body ?? Container(),
          left: 0,
          right: 0,
          bottom: 0,
          top: 0));
      if (widget.floatingActionButton != null) {
        children.add(Positioned(
          child: widget.floatingActionButton!,
          bottom: 30,
          right: 30,
        ));
      }
      var mainChild = Stack(children: children);

      List<Widget> columnChildren = [];
      columnChildren.add(Expanded(child: mainChild, flex: 1));
      if (widget.bottomNavigationBar != null) {
        columnChildren.add(widget.bottomNavigationBar!);
      }

      child = Column(children: columnChildren);
    } else {
      child = widget.body ?? Container();
    }

    var appBar = _buildIOSAppBar();
    if (widget.bottomNavigationBar != null) {
      return CupertinoPageScaffold(
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          navigationBar: appBar,
          key: widget.scaffoldKey,
          child: SafeArea(bottom: false, child: Material(child: child)));
    } else {
      // noStatusBar
      Widget content = Material(
          child: SizedBox(
              width: double.infinity, height: double.infinity, child: child));
      if (widget.noStatusBar != true) {
        content = SafeArea(bottom: widget.applyBottomSafeArea, child: content);
      }
      return CupertinoPageScaffold(
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          navigationBar: appBar,
          key: widget.scaffoldKey,
          child: content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SPPlatform.isIOS() ? _buildiOSScaffold() : _buildAndroidScaffold();
  }
}
