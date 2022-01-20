import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lingo_dragon/common/core/exception.dart';
import 'package:lingo_dragon/common/utils/date_util.dart';
import 'package:lingo_dragon/common/utils/encrypt_util.dart';
import 'package:lingo_dragon/common/utils/platform_util.dart';
import 'package:lingo_dragon/dao/user_dao.dart';
import 'package:lingo_dragon/models/user/login_req_dto.dart';
import 'package:lingo_dragon/models/user/login_type.dart';
import 'package:lingo_dragon/models/user/login_device_info.dart';
import 'package:lingo_dragon/models/user/login_info.dart';
import 'package:lingo_dragon/services/user_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialAuthService {
  static SocialAuthService? _service;
  factory SocialAuthService() {
    _service ??= SocialAuthService._internal();
    return _service!;
  }
  SocialAuthService._internal();

  Future<LoginInfo> signInWithGoogle(LoginDeviceInfo deviceInfo) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // 当用户取消登录操作
    if (googleUser == null) {
      throw SPException(
          code: SPException.userCancelLogin, message: "Operation Cancelled");
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;
    // Create a new credential
    await Firebase.initializeApp();
    final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
    // Once signed in, return the UserCredential
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final idToken = await userCredential.user!.getIdToken(true);

    return _handleSubmitLogin(
        deviceInfo: deviceInfo,
        loginType: LoginType.google,
        thirdToken: idToken);
  }

  Future<LoginInfo> signInWithApple(LoginDeviceInfo deviceInfo) async {
    final String? idToken;
    if (SPPlatform.isIOS()) {
      idToken = await _fetchInWithAppleForIos();
    } else {
      throw SPException(
          code: SPException.unsupport, message: "unsupported platform");
    }

    return _handleSubmitLogin(
        deviceInfo: deviceInfo,
        loginType: LoginType.apple,
        thirdToken: idToken);
  }

  Future<LoginInfo> _handleSubmitLogin(
      {required LoginType loginType,
      required String thirdToken,
      required LoginDeviceInfo deviceInfo}) async {
    var loginRes = await UserDao().login(LoginReqDto(
      thirdToken: thirdToken,
      loginType: loginType.value,
      deviceInfo: deviceInfo,
    ));
    int now = DateTime.now().millisecondsSinceEpoch;
    var loginUserInfo = LoginInfo(
      uid: loginRes.uid,
      email: loginRes.email,
      mobile: loginRes.mobile,
      username: loginRes.username,
      avatar: loginRes.avatar,
      token: loginRes.token,
      expiredTime: loginRes.expiredTime,
      needRefreshTokenTime: SPDateUtil()
          .getTimeByConditionBetweenTwoTime(now, loginRes.expiredTime, true),
    );
    await UserService().saveLoginInfo(loginUserInfo);
    return loginUserInfo;
  }

  Future<String> _fetchInWithAppleForIos() async {
    await Firebase.initializeApp();
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = EncryptUtil.sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    final UserCredential firebaseAuthCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    return firebaseAuthCredential.user!.getIdToken(true);
  }

  Future<String?> signInWithAppleForAndroid() async {
    const redirectURL =
        "https://general-victorious-octopus.glitch.me/callbacks/sign_in_with_apple";
    const clientID = "com.bitguild.lingodragon";

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
            clientId: clientID, redirectUri: Uri.parse(redirectURL)));
    if (kDebugMode) {
      print(appleCredential.identityToken);
    }
    return appleCredential.identityToken;
  }
}
