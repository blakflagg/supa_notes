import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Page2 extends StatefulWidget {
  static const routeName = "/page2";
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                child: Text('User'),
                onPressed: () {
                  User? user = Supabase.instance.client.auth.currentUser;
                  if (user != null) {
                    print(user.id);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
