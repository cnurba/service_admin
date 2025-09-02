/// Defines base endpoints for connection to server.
class ServerAddress {
  ///  Base address for connection.
  /// Test server
  //final String _address = "https://test-muras.maksnurgazy.com/muras/api";

  /// Product server
  final String _address = "https://metal.tez.kg/seitek/hs/mobile";

  /// Api version.
  final String _apiVer = "";

  /// Base url for connection.
  //String get baseUrl => "$_address/$_apiVer";
  String get baseUrl => "$_address";
  String get imageUrl => "$_address/Photos";
}
