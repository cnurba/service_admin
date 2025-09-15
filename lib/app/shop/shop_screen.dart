import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/branches/presentation/list/branch_list_screen.dart';
import 'package:service_admin/app/shop/brands/presentation/list/brand_list_screen.dart';
import 'package:service_admin/app/shop/categories/presentation/list/category_list_screen.dart';
import 'package:service_admin/app/shop/price/presentation/price_list_screen.dart';
import 'package:service_admin/app/shop/products/presentation/my_products/my_products_list.dart';
import 'package:service_admin/app/shop/shop_menu_button.dart';
import 'package:service_admin/app/shop/shop_report_button.dart';
import 'package:service_admin/app/shop/stock/presentation/income_list_screen.dart';
import 'package:service_admin/core/extansions/router_extension.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Учет'),
        actions: [
          IconButton(
            icon: const Icon(Icons.circle_notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 16, top: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Справочники',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 100,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    ShopMenuButton(
                      onTap: () {
                        context.push(CategoryListScreen());
                      },
                      title: 'Категории',
                      icon: Icons.category_outlined,
                    ),

                    ShopMenuButton(
                      onTap: () {
                        context.push(MyProductsList());
                      },
                      title: 'Товары',
                      icon: Icons.shopping_bag_outlined,
                    ),

                    ShopMenuButton(
                      onTap: () {
                        context.push(BrandListScreen());
                      },
                      title: 'Производители',
                      icon: Icons.factory_outlined,
                    ),

                    ShopMenuButton(
                      onTap: () {
                        context.push(BranchListScreen());
                      },
                      title: 'Магазины',
                      icon: Icons.store_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text('Документы', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 14),
              SizedBox(
                height: 100,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    ShopMenuButton(
                      onTap: () {
                        context.push(PriceListScreen());
                      },
                      title: 'Установка цены',
                      icon: Icons.monetization_on,
                    ),

                    ShopMenuButton(
                      onTap: () {
                        context.push(IncomeListScreen(type: "Приход"));
                      },
                      title: 'Поступление товаров',
                      icon: Icons.inventory_2_outlined,
                    ),

                    ShopMenuButton(
                      onTap: () {
                        context.push(IncomeListScreen(type: "Продажа"));
                      },
                      title: 'Продажа товаров',
                      icon: Icons.point_of_sale_outlined,
                    ),

                    ShopMenuButton(
                      onTap: () {
                        context.push(IncomeListScreen(type: "Списание"));
                      },
                      title: 'Списание товаров',
                      icon: Icons.remove_shopping_cart_outlined,
                    ),

                    ShopMenuButton(
                      onTap: () {
                        context.push(IncomeListScreen(type: "Остаток"));
                      },
                      title: 'Ввод остатков',
                      icon: Icons.store_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text('Отчеты', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 14),
              SizedBox(
                height: 100,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    /// Create circle bttons with icons and text below
                    /// with diagrams
                    ShopReportButton(
                      icon: Icons.bar_chart,
                      title: "Продажи",
                      onPressed: () {},
                    ),
                    ShopReportButton(
                      icon: Icons.receipt_long,
                      title: "Заказы",
                      onPressed: () {},
                    ),
                    ShopReportButton(
                      icon: Icons.inventory,
                      title: "Остатки",
                      onPressed: () {},
                    ),
                    ShopReportButton(
                      icon: Icons.price_change,
                      title: "Прайслист",
                      onPressed: () {},
                    ),
                    ShopReportButton(
                      icon: Icons.people_alt,
                      title: "Клиенты",
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text('Новый заказ', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}
