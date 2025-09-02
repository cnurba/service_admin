import 'package:flutter/material.dart';
import 'package:service_admin/app/shop/shop_item.dart';

class ShopItemCard extends StatelessWidget {
  final ShopItem item;
  const ShopItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => item.screen));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey,
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.25),
                    child: Icon(
                      Icons.construction,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
