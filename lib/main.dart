import 'package:flutter/material.dart';
import 'package:luvit/src/core/constant/app_color.dart';
import 'package:luvit/src/features/bottom_nav/view/bottom_nav_bar.dart';
import 'package:luvit/src/features/bottom_nav/view/bottom_nav_bar.dart';
import 'package:luvit/src/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SwipeProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Luvit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: AppColors.darkGreyColor,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        useMaterial3: true,
      ),
      home: BottomNavBar(),
    );
  }
}
