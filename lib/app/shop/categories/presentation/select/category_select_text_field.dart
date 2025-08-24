import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/categories/domain/models/category_model.dart';
import 'package:service_admin/app/shop/categories/presentation/select/category_selectable_screen.dart';

class CategorySelectTextField extends StatefulWidget {
  const CategorySelectTextField({
    super.key,
    required this.initialValue,
    required this.onSelected,
  });

  final String initialValue;
  final Function(CategoryModel) onSelected;

  @override
  State<CategorySelectTextField> createState() =>
      _StateCategorySelectTextField();
}

class _StateCategorySelectTextField extends State<CategorySelectTextField> {
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
          return 'Пожалуйста, выберите категорию';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Категория',
        suffixIcon: IconButton(
          icon: Icon(Icons.arrow_drop_down_circle),
          onPressed: () async {
            final CategoryModel? result = await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return FractionallySizedBox(
                  heightFactor: 0.85,
                  child: CategorySelectableScreen(),
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
