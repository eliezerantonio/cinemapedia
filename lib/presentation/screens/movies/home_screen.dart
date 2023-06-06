import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.viewChild});

  static const name = 'home-screen';

  final Widget viewChild;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: viewChild,
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
