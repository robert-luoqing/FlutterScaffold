# #利用firebase实现谷歌登录

---
### 一. [在 Firebase 中注册您的应用](https://console.firebase.google.com/?hl=zh-cn)

1. 创建Firebase项目
2. 在控制台找到新建项目，进入新建项目
3. 将Firebase项目选择平台，分别添加iOS和Android项目

- [ ] 将 Firebase 添加到您的 Apple 应用中
- 注册应用,填写app的BundleId等信息
- 下载配置文件，按照提示将下载好的GoogleService-Info.plist文件放入iOS项目目录下。
- 后续步骤不用操作，可以执行下面Add dependency操作


- [ ] 将 Firebase 添加到您的 Android 应用
- 注册应用,填写applicationId等信息
- 生成调试签名证书 SHA-1，谷歌登录必填项，参考[文档](https://developers.google.com/android/guides/client-auth)
- 下载配置文件，按照提示将下载好的google-service.json文件放入Android 应用模块的根目录。
- Android项目android/build.gradle下增加 classpath 'com.google.gms:google-services:4.3.10'

```
buildscript {
    ext.kotlin_version = '1.3.50'
    repositories {
        google()
        jcenter()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:4.1.3'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        # 添加这一行
        classpath 'com.google.gms:google-services:4.3.10'
    }
}
```

- 在android/app/build.gradle增加插件apply plugin: 'com.google.gms.google-services'

```
apply plugin: 'com.google.gms.google-services'

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    // Import the Firebase BoM
    implementation platform('com.google.firebase:firebase-bom:29.0.3')
}
```


- [ ] [生成SHA-1示例](https://www.jianshu.com/p/0a80679e6664)

在android目录下终端执行./gradlew signingReport

### 二. Add dependency

```
# Add the dependency for the Firebase Core Flutter SDK
firebase_core: ^1.10.6
# Add the dependencies for the Firebase products you want to use in your app
# For example, to use Firebase Authentication
firebase_auth: ^3.3.3
google_sign_in: ^5.2.1
```
运行 flutter packages get

### 三. 添加代码

socialAuthService.dart
```
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SocialAuthService {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    await Firebase.initializeApp();
    final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
```

调用signInWithGoogle方法，获取idToken后发送给后台校验信息
```
Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final result = await SocialAuthService().signInWithGoogle();
      final idToken = await result.user!.getIdToken(true);
      print(idToken);
      // TODO 发送给后台校验信息
    } catch (e) {
      print(e.toString());
    }
  }
```

Xcode的配置：
将 Google Sign-In 的 URL 方案添加到您的项目
Google Sign-In 需要将自定义 URL Scheme 添加到您的项目中。添加自定义方案：

1. 打开您的项目配置：双击左侧树视图中的项目名称。从选择目标部分的应用程序，然后选择信息选项卡，并展开URL类型部分。

2. 点击+按钮，添加您的反向客户ID作为URL方案。颠倒的客户 ID 是您的客户 ID，点分隔字段的顺序颠倒了。例如：com.googleusercontent.apps.1234567890-abcdefg
