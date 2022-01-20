class SPException {
  static const networkError = "N1000000";
  static const grahpQLError = "N1000001";
  static const unsupport = "N1000002";
  static const userCancelLogin = "N1000003";

  String code;
  String message;
  StackTrace? stackTrace;
  SPException({required this.code, this.message = "", this.stackTrace});
}
