import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/brands/domain/models/brand_model.dart';
import 'package:service_admin/app/shop/brands/presentation/select/brand_selectable_screen.dart';
import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';
import 'package:service_admin/app/shop/categories/presentation/select/category_selectable_screen.dart';

class BrandSelectTextField extends StatefulWidget {
  const BrandSelectTextField({
    super.key,
    required this.initialValue,
    required this.onSelected,
  });

  final String initialValue;
  final Function(BrandModel) onSelected;

  @override
  State<BrandSelectTextField> createState() =>
      _StateBrandSelectTextField();
}

class _StateBrandSelectTextField extends State<BrandSelectTextField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.initialValue;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Пожалуйста, выберите производителя';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Производитель',
        suffixIcon: IconButton(
          icon: Icon(Icons.arrow_drop_down_circle),
          onPressed: () async {
            final BrandModel? result = await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return FractionallySizedBox(
                  heightFactor: 0.85,
                  child: BrandSelectableScreen(),
                );
              },
            );

            if (result != null) {
              controller.text = result.name;
              widget.onSelected(result);
            }
          },
        ),
      ),
      //onChanged: controller.setCategory,
      readOnly: true,
    );
  }
}
