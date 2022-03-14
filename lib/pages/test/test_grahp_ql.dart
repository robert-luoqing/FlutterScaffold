import '../../common/utils/error_util.dart';

import '../../common/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class TestGraphQL extends StatefulWidget {
  const TestGraphQL({Key? key}) : super(key: key);

  @override
  _TestGraphQLState createState() => _TestGraphQLState();
}

class _TestGraphQLState extends State<TestGraphQL> {
  _login() async {
    try {
      // var data = await UserService().login(LoginReqDto(
      //     loginType: LoginType.Phone.value,
      //     countryCode: "86",
      //     mobileNumber: "13530033342",
      //     deviceInfo: LoginDeviceInfo()));

      // print("data: $data");

      // SPDialog.alert(context, data.token);
    } catch (e, s) {
      SPErrorUtil.toastError(context, e, s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SPScaffold(
        title: const Text("GrahpQL"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: _login, child: const Text("Login")),
          ],
        ));
  }
}
