// login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth/auth_notifier.dart';

class LoginPage extends ConsumerStatefulWidget {
  static const routeName = "/loginPage";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.watch(authNotifierProvider.notifier);
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(25),
          child: Container(
            height: 300,
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await authNotifier.signIn(
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                  child: Text('Login'),
                ),
                if (authState.error != null) Text(authState.error!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
