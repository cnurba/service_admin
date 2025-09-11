import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/units/domain/unit_model.dart';
import 'package:service_admin/app/shop/units/presentation/unit_selectable_screen.dart';

class UnitSelectTextField extends StatefulWidget {
  const UnitSelectTextField({
    super.key,
    required this.initialValue,
    required this.onSelected,
  });

  final String initialValue;
  final Function(UnitModel) onSelected;

  @override
  State<UnitSelectTextField> createState() => _StateUnitSelectTextField();
}

class _StateUnitSelectTextField extends State<UnitSelectTextField> {
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
          return 'Пожалуйста, выберите единицу измерения';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Единица измерения',
        suffixIcon: IconButton(
          icon: Icon(Icons.arrow_drop_down_circle),
          onPressed: () async {
            final UnitModel? result = await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return FractionallySizedBox(
                  heightFactor: 0.85,
                  child: UnitSelectableScreen(),
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
