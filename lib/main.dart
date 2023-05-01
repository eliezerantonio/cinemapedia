import 'package:flutter/material.dart';

import './config/theme/app_theme.dart';
import './config/router/app_router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cinemapedia',
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
