import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/price/application/price_provider.dart';
import 'package:service_admin/app/shop/price/domain/model/price_type_model.dart';

class PriceFilterWidget extends StatefulWidget {
  const PriceFilterWidget({super.key, this.onPriceTypeSelected});

  final Function(String)? onPriceTypeSelected;

  @override
  State<PriceFilterWidget> createState() => _PriceFilterWidgetState();
}

class _PriceFilterWidgetState extends State<PriceFilterWidget> {

  String selectedPriceTypeUuid = '';


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final priceTypesAsync = ref.watch(priceTypesProvider);

        final List<PriceTypeModel> priceTypes = priceTypesAsync.maybeWhen(
          data: (v) => v,
          orElse: () => [],
        );

        return SizedBox(
          height: 36,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: priceTypes.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedPriceTypeUuid == priceTypes.elementAt(index).uuid
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedPriceTypeUuid = priceTypes.elementAt(index).uuid;
                      widget.onPriceTypeSelected?.call(selectedPriceTypeUuid);
                    });
                    // You can also notify other parts of your app about the selection change here
                  },
                  child: Text(priceTypes.elementAt(index).name),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
