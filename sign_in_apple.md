# signInApple
```
dependencies:
  firebase_auth: ^3.3.3
  sign_in_with_apple: ^3.0.0
  crypto: ^3.0.1
  firebase_core: ^1.10.6
```

## IOS
---

  1. 在firebase上创建项目，创建IOS应用，填写软件包ID(即：application的bundleID,与Xcode上的保持一致),
    之后下载GoogleService-Info.plist配置文件，根据提示在Xcode上放到项目根目录。之后直接下一步下一步到注册应用。完成注册。
  2. 在[firebase控制台](https://console.firebase.google.com/project/test-d345c/authentication/providers),
     打开Authentication，在Sign-in method中添加新登录提供方Apple
     **由于IOS仅使用Apple登录功能，所以其他字段可以留空，保存即可**
  3. 在Xcode中的signing & Capabilities中添加Sign in with Apple一栏
  4. 在Apple developer网站上的[Identifiers](https://developer.apple.com/account/resources/identifiers/list)添加一项，依次按以下步骤
      * 选择App IDS
      * 选择App类型
      * BundleID填写application的bundleID,与Xcode上的保持一致. Capabilities中勾选“Sign In with Apple”,使用默认配置就行.
      * 保存
         - 这里可以同时对Android需要的秘钥和Service ID进行创建

  

## Android
---
  > 由于flutter的身份认证不支持firebase的Android登录Apple方式，所以使用sign_in_with_apple的调用方法。
  1. 秘钥
    在Apple developer网站上的[Keys](https://developer.apple.com/account/resources/authkeys/list)添加一项，依次按以下步骤
      * 填写Key Name
      * 选中“Sign In with Apple”,配置选择之前添加好了的App ID
      * 保存
      * Download 秘钥，可以看到创建好了的key的KeyID这些配置service的时候需要
  2. Service ID
    在Apple developer网站上的[Identifiers](https://developer.apple.com/account/resources/identifiers/list)添加一项，依次按以下步骤
      * 选择Services IDs
      * Identifier填写application的bundleID,与android/app/build.gradle文件里的applicationId和android/app/src/profile/AndroidManifest.xml里的package保持一致.
      * register注册完成.
      * 在Services IDs列表里找到刚注册的项，点进去。启用“Sign In with Apple”
      * 配置“Sign In with Apple”: 需要填写Website URLS。
        - In the Domains and Subdomains add the domains of the websites on which you want to use Sign in with Apple, e.g. example.com. You have to enter at least one domain here, even if you don't intend to use Sign in with Apple on any website.**这里是有必须要提供的域名，即便不需要在任何网站上登录Apple账号**
        - In the Return URLs box add the full return URL you want to use.
        **这里的returnURLs与调用登录时传的重定向URL保持一致，需要在服务器构建一个,以下有说明和示例,是否采用glitch的服务**
        ---
        服务器部分通常集成到您现有的后端中，并且有适用于大多数现有编程语言和 Web 框架的现有包。<br>
        为了展示如何构建一个完整的示例，我们在[Glitch](https://glitch.com)上设置了一个示例项目，该项目提供简单且免费的支持 HTTPS 的 Web API 的托管，这正是此处所需要的。<br>
        要开始使用基于 Glitch 的示例，请转到位于https://glitch.com/~flutter-sign-in-with-apple-example的项目页面，然后单击“Remix this”。现在您拥有自己的示例服务器副本！<br>
        首先.env在左侧的文件浏览器中选择文件并输入您的凭据（这些不会公开，只会与受邀的合作者共享）。<br>
        然后点击左上角头像旁边的“分享”按钮，选择“Live App”并复制入口页面的网址（例如https://some-random-identifier.glitch.me）。<br>
        现在更新您之前在https://developer.apple.com/account/resources/identifiers/list/serviceId创建的服务，以在Return URLs:下包含以下 URL https://YOUR-PROJECT-NAME.glitch.me/callbacks/sign_in_with_apple（替换 中的名称[]）。

        在.env中可填写的字段有
          - TEAM_ID
          >Found in the top-right corner of https://developer.apple.com/account/resources/certificates/list under your name
          - SERVICE_ID 
          > Go to https://developer.apple.com/account/resources/identifiers/list/serviceId, click on the service and copy the "Identifier" value
          - BUNDLE_ID 
          > The Bundle ID of your app
          - KEY_ID 
          > Go to https://developer.apple.com/account/resources/authkeys/list and select the key you created for Sign in with Apple
          - KEY_CONTENTS 
          > The contents of service key downloaded during the service creation Replace all line-breaks with `|`
          - ANDROID_PACKAGE_IDENTIFIER 
          > Your package identifier from the Google Play Store e.g. com.example.app For the example app provided with the plugin, use `com.aboutyou.dart_packages.sign_in_with_apple_example`
        ---
  3. android文件相关改动
  * 上面讲的application的bundleID需要几个地方保持一致
  * android/build.gradle的ext.kotlin_version需要改为1.5.0
  * android/app/build.gradle的compileSdkVersion需要改为31
  * android/app/src/main/kotlin/com/sp/scaffold/MainActivity.kt中在configureFlutterEngine方法内添加super.configureFlutterEngine(flutterEngine);
    ```
      override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        # 添加这一行, 不然会出现MissingPluginException(No implementation found for method Firebase#initializeCore on channel plugins类似报错
        super.configureFlutterEngine(flutterEngine);
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("SPVideoView", VideoViewFactory(flutterEngine.dartExecutor.binaryMessenger))

        this.applicationContext
    }
    ```


### service方法
---
```
static Future<String?> appleLogin() async {
    try {
      final String? idToken;
      if (Platform.isIOS) {
        idToken = await appleLoginForIos();
      } else {
        idToken = await appleLoginForAndroid();
      }
      return idToken;
    } catch (err) {
      print('catchError: ' + err.toString());
    }
  }

  static Future<String?> appleLoginForIos() async {
    await Firebase.initializeApp();
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

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

  static Future<String?> appleLoginForAndroid() async {
    final redirectURL =
        "https://general-victorious-octopus.glitch.me/callbacks/sign_in_with_apple";
    final clientID = "com.demosingIn.gc";

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
            clientId: clientID, redirectUri: Uri.parse(redirectURL)));
    print(appleCredential.identityToken);
    return appleCredential.identityToken;
  }
```