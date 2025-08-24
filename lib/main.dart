import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/core/http/dio_interceptor.dart';
import 'package:service_admin/core/http/server_address.dart';
import 'package:service_admin/injection.dart';
import 'package:service_admin/run_service_admin_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await _init();
  /// Initialize Dio with custom options and interceptors
  /// This is where you can set up Dio for making HTTP requests
  /// and add any interceptors you might need for logging, error handling, etc.
  getIt<Dio>()
    ..options = BaseOptions(
      baseUrl: ServerAddress().baseUrl, // Replace with your API base URL
      connectTimeout: const Duration(milliseconds: 7000),
      receiveTimeout: const Duration(milliseconds: 6000),
      sendTimeout: const Duration(milliseconds: 6000),
    )
    ..interceptors.add(getIt<DioInterceptor>());
  runApp(ProviderScope(child: const ServiceAdminApp()));
}

_init() async {
  initDependencies();
}
