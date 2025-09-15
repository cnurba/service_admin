import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/stock/application/income_repository_provider.dart';
import 'package:service_admin/core/presentation/errors/failure.dart';

import 'basket_state.dart';

final basketPostProvider = FutureProvider.autoDispose
    .family<FailureModel, BasketState>((ref, data) async {
      final basketRepository = ref.watch(incomeRepositoryProvider);
      return await basketRepository.post(data, data.type);
    });
