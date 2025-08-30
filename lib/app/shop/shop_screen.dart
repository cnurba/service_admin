import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/branches/presentation/list/branch_list_screen.dart';
import 'package:service_admin/app/shop/brands/presentation/list/brand_list_screen.dart';
import 'package:service_admin/app/shop/categories/presentation/list/category_list_screen.dart';
import 'package:service_admin/app/shop/price/presentation/price_list_screen.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/my_products_list.dart';
import 'package:service_admin/app/shop/stock/presentation/stock_list_screen.dart';

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
            leading: const Icon(Icons.shopping_cart),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CategoryListScreen()),
              );
            },
          ),
          SizedBox(height: 12),
          ListTile(
            title: const Text('Производители'),
            leading: const Icon(Icons.branding_watermark),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BrandListScreen()),
              );
            },
          ),
          SizedBox(height: 12),
          ListTile(
            title: const Text('Магазины и Филиалы'),
            leading: const Icon(Icons.shop),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BranchListScreen()),
              );
            },
          ),
          SizedBox(height: 12),
          ListTile(
            title: const Text('Товары'),
            leading: const Icon(Icons.production_quantity_limits_outlined),
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => MyProductsList()));
            },
          ),
          SizedBox(height: 12),
          ListTile(
            title: const Text('Цены'),
            leading: const Icon(Icons.price_change),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PriceListScreen()),
              );
            },
          ),
          SizedBox(height: 12),
          ListTile(
            title: const Text('Остатки'),
            leading: const Icon(Icons.gpp_maybe_rounded),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => StockListScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
