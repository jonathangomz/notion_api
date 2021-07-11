import 'package:notion_api/statics.dart';

abstract class BaseClient {
  /// The API integration secret token.
  String token;

  /// The API version.
  String v;

  /// The API date version.
  ///
  /// It's not the same as the API version.
  String dateVersion;

  /// The path of the requests group.
  String path = '';

  BaseClient({
    required String token,
    String version: latestVersion,
    String dateVersion: latestDateVersion,
  })  : this.token = token,
        this.v = version,
        this.dateVersion = dateVersion;
}
