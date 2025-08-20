import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:service_admin/app/shop/brands/domain/repositories/i_brand_repository.dart';
import 'package:service_admin/app/shop/brands/infrastructure/repositories/brand_repository.dart';
import 'package:service_admin/app/shop/categories/domain/repositories/i_category_repository.dart';
import 'package:service_admin/app/shop/categories/infrastructure/repositories/category_repository.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_my_product_repository.dart';
import 'package:service_admin/app/shop/products/domain/repositories/i_product_repository.dart';
import 'package:service_admin/app/shop/products/infrastructure/repositories/my_product_repository.dart';
import 'package:service_admin/app/shop/products/infrastructure/repositories/product_repository.dart';
import 'package:service_admin/auth/domain/repositories/i_token_storage.dart';
import 'package:service_admin/auth/infrastucture/repositories/auth_repository.dart';
import 'package:service_admin/auth/infrastucture/repositories/token_storage.dart';
import 'package:service_admin/core/http/dio_interceptor.dart';
import 'package:service_admin/core/services/image_picker/i_image_picker_repository.dart';
import 'package:service_admin/core/services/image_picker/image_picker_repository.dart';

import 'auth/domain/repositories/i_auth_repository.dart';

// Создай глобальный экземпляр GetIt
final GetIt getIt = GetIt.instance;

void initDependencies() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<ITokenStorage>(() => TokenStorage(getIt()));
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioInterceptor>(
    () => DioInterceptor(getIt(), getIt()),
  );

  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(getIt<ITokenStorage>(), getIt<Dio>()),
  );
  //
  getIt.registerLazySingleton<ICategoryRepository>(
    () => CategoryRepository(getIt()),
  );
  getIt.registerLazySingleton<IImagePickerRepository>(
    () => ImagePickerRepository(getIt<Dio>()),
  );
  getIt.registerLazySingleton<IBrandRepository>(() => BrandRepository(getIt()));
  getIt.registerLazySingleton<IProductRepository>(
    () => ProductRepository(getIt()),
  );
  getIt.registerLazySingleton<IMyProductRepository>(
    () => MyProductRepository(getIt()),
  );
  // getIt.registerLazySingleton<IOrderToSupplierRepository>(() => OrderToSupplierRepository(getIt()));
  // getIt.registerLazySingleton<IClientRepository>(() => ClientRepository(getIt()));
}
