// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supa_notes/services/auth/auth_notifier.dart';

class HomePage extends ConsumerWidget {
  static const routeName = '/homePage';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authNotifier.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome!'),
      ),
    );
  }
}
