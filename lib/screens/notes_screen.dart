import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supa_notes/services/auth/auth_notifier.dart';
import 'package:supa_notes/services/notes/notes_provider.dart';

class NotesScreen extends ConsumerStatefulWidget {
  static const routeName = '/notesScreen';
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  Future<void>? _pendingAddNote;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue notes = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            child: notes.when(
              loading: () => CircularProgressIndicator(),
              error: (error, statck) => Text('Error $error'),
              data: (value) => ListView.builder(
                itemCount: value.length,
                itemBuilder: (ctx, i) => Card(
                  child: ListTile(
                    title: Text(value[i].title),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(notesProvider.notifier).getNotesFromAPI();
            },
            child: Text('Get Notes'),
          ),
        ],
      ),
    );
  }
}
