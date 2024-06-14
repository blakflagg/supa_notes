import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/note.dart';

class NoteTest {
  Future<void> getNotesFromAPI() async {
    final _supabase = Supabase.instance.client;

    const userId = "837457a2-f526-42ca-a69f-0727a06468fa";

    // final List<Map<String, dynamic>> response =
    //     await _supabase.from("tblnotes").select("*").eq("user_id", userId);
    final response =
        await _supabase.from("tblnotes").select("*").eq("user_id", userId);
    List<Note> notes = response.map((note) => Note.fromJson(note)).toList();

    notes.forEach((note) => print('Note: ${note.id} - ${note.title}'));
  }
}
