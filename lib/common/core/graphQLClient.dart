import 'dart:ui';
import 'exception.dart';
import 'package:graphql/client.dart';

typedef SPGraphQLClientHeaderCallback = Future<Map<String, String>> Function();

class GrahpQLClient {
  static GrahpQLClient? _cache;

  factory GrahpQLClient() {
    if (_cache == null) {
      _cache = GrahpQLClient._internal();
    }
    return _cache!;
  }

  GrahpQLClient._internal();
  SPGraphQLClientHeaderCallback? onHeaderCallback;
  Map<String, String> _defaultHeaders = <String, String>{};
  String host = "";

  void addDefaultHeaders(String key, String value) {
    _defaultHeaders[key] = value;
  }

  void removeAllDefaultHeaders() {
    _defaultHeaders = <String, String>{};
  }

  VoidCallback? onTokenExpired;

  dynamic query(
      {required String queryQL, Map<String, dynamic>? variables}) async {
    var headers = await this._getHeaders();
    final _link = HttpLink(
      this.host,
      defaultHeaders: headers,
    );

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );

    final QueryOptions options = QueryOptions(
      document: gql(queryQL),
      variables: variables ?? {},
    );

    final QueryResult result = await client.query(options);

    return _handleResult(result);
  }

  dynamic mutate(
      {required String mutationQL, Map<String, dynamic>? variables}) async {
    var headers = await this._getHeaders();
    final _link = HttpLink(
      this.host,
      defaultHeaders: headers,
    );

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );

    final MutationOptions options = MutationOptions(
      document: gql(mutationQL),
      variables: variables ?? {},
    );

    final QueryResult result = await client.mutate(options);

    return _handleResult(result);
  }

  dynamic _handleResult(QueryResult result) {
    if (result.hasException) {
      var exception = result.exception!;

      for (var error in exception.graphqlErrors) {
        print(
            "grahql error extensions: ${error.extensions},path: ${error.path}, locations: ${error.locations}, message: ${error.message}");
        throw SPException(
            code: SPException.GrahpQLError, message: error.message);
      }
      print("link error: ${exception.linkException?.toString()}");

      throw SPException(
          code: SPException.NetworkError, message: "Network Error");
    }

    if (result.data != null) {
      var data = result.data!;
      data.removeWhere((key, value) => key == "__typename");
      List<dynamic> retu = [];
      if (data.length > 0) {
        for (var item in data.entries) {
          var code = (item.value["code"] ?? "").toString();
          var msg = (item.value["message"] ?? "").toString();
          if (code != "200") {
            throw SPException(code: code, message: msg);
          }

          retu.add(item.value);
        }
      }
      // If only one graphql, then return data directly
      // If multipe graphql, then return list
      if (retu.length == 1) {
        return retu[0];
      } else {
        return retu;
      }
    }

    return null;
  }

  Future<Map<String, String>> _getHeaders() async {
    var headers = Map<String, String>.from(_defaultHeaders);
    if (this.onHeaderCallback != null) {
      var cuheaders = await this.onHeaderCallback!();
      headers.addAll(cuheaders);
    }
    return headers;
  }
}
