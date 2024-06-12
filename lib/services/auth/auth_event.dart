import 'package:supabase_flutter/supabase_flutter.dart';

class AuthEvent {
  Session? session;
  AuthChangeEvent? event;
  User? user;

  AuthEvent({this.session, this.event, this.user});
}
