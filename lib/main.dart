import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/locator.dart';
import 'package:roqqu_trade/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Roqqu Trade',
      debugShowCheckedModeBanner: false,
      home: TradeScreen(),
    );
  }
}
