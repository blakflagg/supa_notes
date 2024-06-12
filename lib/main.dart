import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supa_notes/screens/login.dart';
import 'package:supa_notes/services/auth/auth_notifier.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './screens/home.dart';
import './screens/page2.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_API_KEY']!,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countries',
      home: AuthWrapper(),
      routes: {
        HomePage.routeName: (ctx) => const HomePage(),
        Page2.routeName: (ctx) => const Page2(),
      },
      navigatorObservers: [routeObserver],
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('ReRender Auth Wrapper');
    final authState = ref.watch(authNotifierProvider);
    print(authState.user);
    if (authState.isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return authState.user != null ? HomePage() : LoginPage();
  }
}
