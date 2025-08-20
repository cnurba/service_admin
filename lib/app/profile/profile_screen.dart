
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/auth/application/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          return Center(
            child: ElevatedButton(onPressed: (){
              ref.read(authControllerProvider.notifier).signOut().then((_) {;
                // After signing out, navigate to the login screen
                // and remove all previous routes from the stack
              });
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            }, child: Text("Выход"))
          );
        },

      ),
    );
  }
}
