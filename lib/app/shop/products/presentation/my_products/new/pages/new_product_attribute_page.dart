import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/attribute_list/attribute_list_future_provider.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_images/new_product_image_provider.dart';
import 'package:service_admin/app/shop/products/application/application/product_attribute/product_attribute_future_provider.dart';
import 'package:service_admin/app/shop/products/domain/models/attribute/attribute.dart';

class NewProductAttributeScreen extends ConsumerWidget {
  const NewProductAttributeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productId = ref.watch(newProductImageProvider).productUuid;
    final attributesAsync = ref.watch(
      productAttributeFutureProvider(productId),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showNewAttributeSheet(context, productId);
        },
        label: const Text('Добавить новый атрибут'),
        icon: const Icon(Icons.add),
      ),
      body: attributesAsync.when(
        data: (attributes) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: attributes.length,
            itemBuilder: (context, index) {
              final attribute = attributes[index];

              /// Display attribute name and value in a card
              return Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(attribute.productName),
                    const SizedBox(height: 4),
                    Text(attribute.name),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  showNewAttributeSheet(BuildContext context, String productId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.85,
        child: NewAttributeSheet(productId: productId),
      ),
    );
  }
}

class NewAttributeSheet extends ConsumerStatefulWidget {
  const NewAttributeSheet({super.key, required this.productId});

  final String productId;

  @override
  ConsumerState<NewAttributeSheet> createState() => _NewAttributeSheetState();
}

class _NewAttributeSheetState extends ConsumerState<NewAttributeSheet> {
  TextInputType keyboardType = TextInputType.text;
  Attribute? selectedAttribute;
  final TextEditingController _controller = TextEditingController();

  void updateKeyboardType(Attribute? attribute) {
    if (attribute == null) return;
    setState(() {
      if (attribute.type == 'Число') {
        keyboardType = TextInputType.number;
      } else if (attribute.type == 'Строка' ||
          attribute.type == 'Дополнительные значения характеристики') {
        keyboardType = TextInputType.text;
      } else if (attribute.type == 'Да/Нет') {
        keyboardType = TextInputType.none; // Hide the keyboard
      } else {
        keyboardType = TextInputType.text; // Default to text
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.productId,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 16.0),

          /// Dropdown for attribute type
          AttributeListTile(
            onChanged: (attribute) {
              // Handle attribute selection
              setState(() {
                selectedAttribute = attribute;
              });
              updateKeyboardType(attribute);
            },
          ),

          /// Create a text field for value
          /// If attribute type is Число, show a number keyboard
          /// If attribute type is Строка, show a text keyboard
          /// If attribute type is "Дополнительные значения характеристики", show a text keyboard
          /// If attribute type is "Да/Нет", hide the text field
          const SizedBox(height: 16.0),
          TextField(
            controller: _controller,
            keyboardType: keyboardType,
            decoration: const InputDecoration(
              labelText: 'Attribute Value',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                if (selectedAttribute == null) {
                  // Show error
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Выберите атрибут')),
                  );
                  return;
                }
                Map<String, dynamic> attributeData = {
                  "uuid": widget.productId,
                  "attribute": selectedAttribute!.toJson(),
                  "value": _controller.text,
                };

                ref.read(attributeCreateProvider(attributeData).future).then((
                  value,
                ) {
                  if (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Атрибут успешно создан')),
                    );
                    Future.microtask(() {
                      ref.refresh(
                        productAttributeFutureProvider(widget.productId),
                      );
                      Navigator.pop(context);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ошибка при создании атрибута'),
                      ),
                    );
                  }
                });
              },
              child: const Text('Save Attribute'),
            ),
          ),
        ],
      ),
    );
  }
}

/// Create a widget dropdown to select attribute type
/// This widget can be used in the main screen to list attributes
/// Uses [attributeFutureProvider] to fetch and display attributes
class AttributeListTile extends ConsumerWidget {
  const AttributeListTile({super.key, this.onChanged});

  final Function(Attribute)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attributesAsync = ref.watch(attributeFutureProvider);
    return attributesAsync.when(
      data: (attributes) {
        return DropdownButtonFormField<Attribute>(
          decoration: const InputDecoration(
            labelText: 'Select Attribute',
            border: OutlineInputBorder(),
          ),
          items: attributes.map((attribute) {
            return DropdownMenuItem<Attribute>(
              value: attribute,
              child: Text(attribute.name),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null && onChanged != null) {
              onChanged!(value);
            }
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
