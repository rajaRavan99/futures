import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Sign In with'),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.email!,
              ),
              ElevatedButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  child: const Text('Logout'))
            ],
          ),
        ),
      ),
    );
  }
}
