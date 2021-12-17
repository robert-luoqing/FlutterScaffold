# FlutterScaffold
Build Scaffold which include a lot of widgets which coming from pub.dev

- Principle
Developers should not always concern how to style UI. We need wrap UI element from flutter basic widgets to keep UI consist.

- Folder agreement
  1. lib/common/constant  
The folder will put constant like Colors(It may remove becuase multiple skins), Error Codes and constant string in it.
  2. lib/common/controlls
The folder will wrap most of widgets of which we need style. and it a widget need provider multiple styles in project, we have pattern property to indicate which style pattern will be used. it can make project style consist if multiple develper corpration togather. 
For example, if a project has three styles buttton, like blue button(normal), red button(alert) and grey button, we shoule provide a pattern enumeration which include normal/alert/second three options.  
  3. lib/common/core
The folder will provide core code, like wrap http code, websocket code and some important infrastracture code.  
  4. lib/common/utils
All utils files will put the folder. Notice, code in utils should not dependency other folder's code. these files can be copy to other project with no any change.  


## To generate json code(https://pub.dev/packages/json_serializable)
flutter pub run build_runner build --delete-conflicting-outputs

## flutter_native_splash
flutter pub run flutter_native_splash:create

## Build Android Package
flutter build apk --no-tree-shake-icons --split-per-abi
