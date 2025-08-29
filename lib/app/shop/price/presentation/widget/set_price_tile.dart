import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/price/domain/model/price_model.dart';

class SetPriceTile extends StatelessWidget {
  const SetPriceTile({super.key, required this.priceModel, this.onDelete});

  final PriceModel priceModel;
  final VoidCallback? onDelete;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(priceModel.productName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(priceModel.productPropertyName),
          Text(
            'Остаток: ${priceModel.stock} ${priceModel.unitName}',
          ),
        ],
      ),

      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }
}
