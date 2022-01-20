enum LoginType { phone, email, apple, google }

extension LoginTypeExtension on LoginType {
  int get value => index + 1;
}
