import 'package:service_admin/core/http/server_address.dart';

final String _baseUrl = ServerAddress().baseUrl;

/// Defines endpoints for authentication.
class _Auth {
  String get login => "$_baseUrl/auth/GetToken";

  String get refresh => "$_baseUrl/auth/refresh-token";
}

class _Categories {
  String get categories => "$_baseUrl/categories";
}

class _Brands {
  String get brands => "$_baseUrl/brands";
}

class _Branches {
  String get branches => "$_baseUrl/branches";
}

class _Products {
  String get products => "$_baseUrl/products";
  String get myProducts => "$_baseUrl/products/my";

  String get branchProducts => "$_baseUrl/branchProducts";

  String get attributes => "$_baseUrl/atributes";

  String get productAttributes => "$_baseUrl/productAttribute";
}

class _Files {
  String get file => "$_baseUrl/file";

  String get fileProduct => "$_baseUrl/file/product";
}


class _PriceTypes {
  String get priceType => "$_baseUrl/priceTypes";
  String get prices => "$_baseUrl/prices";
}

class _Price {
  String get prices => "$_baseUrl/price";
}

class _Stocks {
  String get stocks => "$_baseUrl/products";
}

class _ProductAttributes {
  String get productAttributes =>
      "$_baseUrl/products?=4ad58982-232c-11f0-a3f0-005056c00009";
}

class _Incomes {
  String get income => "$_baseUrl/income";
}

/// Defines endpoints for connection to server.
class Endpoints {
  static get categories => _Categories();

  static get files => _Files();

  static get brands => _Brands();

  static get branches => _Branches();

  static get products => _Products();

  static get income => _Incomes();

  static get priceType => _PriceTypes();
  static get price => _Price();

  static get stocks => _Stocks();

  static get productAttributes => _ProductAttributes();

  static get auth => _Auth();
}
