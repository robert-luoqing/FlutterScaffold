import 'package:FlutterScaffold/common/controlls/dialog.dart';
import 'package:FlutterScaffold/models/user/loginReqDto.dart';

import '../../services/userService.dart';

import '../../common/utils/errorUtil.dart';

import '../../common/controlls/scaffold.dart';
import 'package:flutter/material.dart';

class TestGraphQL extends StatefulWidget {
  const TestGraphQL({Key? key}) : super(key: key);

  @override
  _TestGraphQLState createState() => _TestGraphQLState();
}

class _TestGraphQLState extends State<TestGraphQL> {
  _login() async {
    try {
      var data = await UserService().login(LoginReqDto(
          countryCode: "86",
          mobileNumber: "13530033342",
          password: "lq0001LQ",
          deviceId: "33333dsd",
          macAddress: "32423423",
          platform: "Ios",
          version: "2.1.0",
          os: "Ios",
          model: "",
          brand: "",
          maxVersion: "",
          ip: ""));

      print("data: $data");

      SPDialog.alert(context, data.token);
    } catch (e, s) {
      SPErrorUtil.toastError(context, e, s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: Text("GrahpQL"),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(onPressed: _login, child: Text("Login")),
            ],
          ),
        ));
  }
}
