import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/shop/products/application/application/new_product_images/new_product_image_provider.dart';
import 'package:service_admin/core/presentation/errors/state_wrapper.dart';
import '../../../../../brands/application/brand_image/brand_future_provider.dart';

class NewProductImagesPage extends StatelessWidget {
  const NewProductImagesPage({super.key, this.onSuccess});

  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final imageState = ref.watch(newProductImageProvider);
        return Scaffold(
          floatingActionButton: StateWrapper(
            stateType: imageState.stateType,
            onSuccess:onSuccess,
            errorChild: Center(
              child: ElevatedButton(
                onPressed: () {
                  if(imageState.selectedImages.isNotEmpty) {
                    ref.read(newProductImageProvider.notifier).postImages();
                  }
                },
                child: const Text('Повторить'),
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                if(imageState.selectedImages.isNotEmpty) {
                  ref.read(newProductImageProvider.notifier).postImages();
                }
              },
              child: const Text('Сохранить'),
            ),
          ),
          body: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: imageState.selectedImages.length + 1, // Example item count
            itemBuilder: (context, index) {
              final images = imageState.selectedImages;
              final image = index < images.length ? images[index] : null;
              if (index+1  == images.length + 1) {
                return GestureDetector(
                  onTap: () async {
                    final selectedImage = await ref
                        .read(imageRepositoryProvider)
                        .pickImageFromGalleryWithoutPost();
                    if (selectedImage != null) {
                      ref
                          .read(newProductImageProvider.notifier)
                          .addImage(selectedImage);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.green.withOpacity(0.1),
                    ),
                    child: const Center(child: Icon(Icons.add)),
                  ),
                );
              }
              return Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0),
                      image: image != null
                          ? DecorationImage(
                              image: FileImage(image),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: SizedBox.shrink(),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(newProductImageProvider.notifier)
                            .removeImageAt(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
