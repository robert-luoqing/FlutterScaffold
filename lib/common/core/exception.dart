class SPException {
  static const NetworkError = "N1000000";
  static const GrahpQLError = "N1000001";

  String code;
  String message;
  StackTrace? stackTrace;
  SPException({required this.code, this.message = "", this.stackTrace});
}
