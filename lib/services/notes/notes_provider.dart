import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supa_notes/services/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supa_notes/models/note.dart';
import 'package:http/http.dart';

class NotesProvider extends AutoDisposeAsyncNotifier<List<Note>> {
  String userId = "";

  @override
  Future<List<Note>> build() async {
    final authState = ref.watch(authServiceProvider);
    userId = authState.user?.id ?? "None";
    final notes = await getNotesFromAPI();

    return notes;
  }

  Future<List<Note>> getNotesFromAPI() async {
    final _supabase = Supabase.instance.client;

    final response =
        await _supabase.from("tblnotes").select("*").eq("user_id", userId);
    List<Note> notes = response.map((note) => Note.fromJson(note)).toList();
    print('getNotesFromAPI fired');
    // state = AsyncData(notes);
    return notes;
  }

  void printState() {
    print(state);
  }
}

final notesProvider =
    AsyncNotifierProvider.autoDispose<NotesProvider, List<Note>>(
  NotesProvider.new,
);
