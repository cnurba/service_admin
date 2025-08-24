
import 'package:flutter/material.dart';

class NewProductImagesPage extends StatelessWidget {
  const NewProductImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: 9, // Example item count
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[300],
          child: Center(child: Text('Image ${index + 1}')),
        );
      },
    );
  }
}
