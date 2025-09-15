import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/price/domain/model/price_model.dart';
import 'package:service_admin/app/shop/price/domain/model/set_price_model.dart';
import 'package:service_admin/core/presentation/slidable/app_slidable.dart';

class SetPriceTile extends StatelessWidget {
  const SetPriceTile({super.key, required this.setPriceModel, this.onDelete});

  final SetPriceModel setPriceModel;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return AppSlidable(
      onDelete: (p0) {
        onDelete?.call();
      },
      id: setPriceModel.priceModel.productPropertyUuid,
      child: ListTile(
        title: Text(setPriceModel.priceModel.productName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(setPriceModel.priceModel.productPropertyName),
            Text(
              'Остаток: ${setPriceModel.priceModel.stock} ${setPriceModel.priceModel.unitName}',
            ),
          ],
        ),
        trailing: Text(
          '${setPriceModel.price}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        // leading:
      ),
    );
  }
}
