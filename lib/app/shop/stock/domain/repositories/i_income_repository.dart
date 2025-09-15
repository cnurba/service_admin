import 'package:service_admin/app/shop/stock/application/basket_provider/basket_state.dart';
import 'package:service_admin/app/shop/stock/domain/models/income_model.dart';
import 'package:service_admin/core/presentation/errors/failure.dart';


abstract class IIncomeRepository {
  Future<FailureModel> post(BasketState state, String type);
  Future<List<IncomeModel>> getProductsWithAttributes();
}
