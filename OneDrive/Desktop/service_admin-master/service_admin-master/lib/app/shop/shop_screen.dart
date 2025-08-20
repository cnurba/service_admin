import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/branches/presentation/list/branch_list_screen.dart';
import 'package:service_admin/app/shop/brands/presentation/list/brand_list_screen.dart';
import 'package:service_admin/app/shop/categories/presentation/list/category_list_screen.dart';
import 'package:service_admin/app/shop/products/presentation/list/product_list_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Магазин'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Handle search action
              },
            ),
          ],
        ),
        body: ListView(
            children: [
              ListTile(
                title: const Text('Категории'),
                subtitle: const Text('Description of Item 1'),
                leading: const Icon(Icons.shopping_cart),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CategoryListScreen()),
                  );
                },
              ),
              SizedBox(height: 16),
              ListTile(
                title: const Text('Производители'),
                subtitle: const Text('Description of Item 1'),
                leading: const Icon(Icons.branding_watermark),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BrandListScreen()),
                  );
                },
              ),
              SizedBox(height: 16),
              ListTile(
                title: const Text('Магазины и Филиалы'),
                subtitle: const Text('Description of Item 1'),
                leading: const Icon(Icons.shop),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BranchListScreen()),
                  );
                },
              ),
              SizedBox(height: 15),
              ListTile(
                title: const Text('Товары'),
                subtitle: const Text('Description of Item 1'),
                leading: const Icon(Icons.production_quantity_limits_outlined),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProductListScreen()),
                  );
                },
              ),
            ],
          ),
       );
   }
}