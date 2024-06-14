// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supa_notes/screens/notes_screen.dart';
import 'package:supa_notes/services/auth/auth_notifier.dart';
import 'package:supa_notes/services/notes/notes_provider.dart';
import '../services/notes/notes_test.dart';

class HomePage extends ConsumerWidget {
  static const routeName = '/homePage';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authNotifierProvider.notifier);
    final nt = NoteTest();
    ref.read(notesProvider.notifier).getNotesFromAPI();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // nt.getNotesFromAPI();
                ref.read(notesProvider.notifier).printState();
              },
              child: const Text('Test'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NotesScreen.routeName);
              },
              child: Text('Open Notes List'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(authNotifierProvider.notifier).signOut();
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
