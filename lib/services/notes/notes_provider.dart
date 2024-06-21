import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supa_notes/services/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supa_notes/models/note.dart';

class NotesProvider extends AutoDisposeAsyncNotifier<List<Note>> {
  String userId = "";
  final _supabase = Supabase.instance.client;

  @override
  Future<List<Note>> build() async {
    final authState = ref.watch(authServiceProvider);
    userId = authState.user?.id ?? "None";
    final notes = await getNotesFromAPI();

    return notes;
  }

  Future<List<Note>> getNotesFromAPI() async {
    final response =
        await _supabase.from("tblnotes").select("*").eq("user_id", userId);
    List<Note> notes = response.map((note) => Note.fromJson(note)).toList();
    print('getNotesFromAPI fired');

    return notes;
  }

  Future<void> addNote(Note note) async {
    print('add note');
    print(note.toJson());
    try {
      final response =
          await _supabase.from("tblnotes").insert(note.toJson()).select();
      List<Note> notes = response.map((note) => Note.fromJson(note)).toList();
      // state = AsyncData(notes);
      final currentState = state.valueOrNull ?? [];
      state = AsyncValue.data([...currentState, ...notes]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      final response =
          await _supabase.from("tblnotes").delete().eq("id", id).select();
      List<Note> notes = response.map((note) => Note.fromJson(note)).toList();
      // state = AsyncData(notes);
      final currentState = state.valueOrNull ?? [];
      state = AsyncValue.data([...currentState, ...notes]);
    } catch (e) {
      print(e);
    }
  }

  void printState() {
    print(state);
  }
}

final notesProvider =
    AsyncNotifierProvider.autoDispose<NotesProvider, List<Note>>(
  NotesProvider.new,
);
