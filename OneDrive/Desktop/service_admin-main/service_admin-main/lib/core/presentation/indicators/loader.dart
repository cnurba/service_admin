import 'package:flutter/material.dart';

/// if IOS then open the loader in Cupertino style
/// if Android then open the loader in Material style
class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
