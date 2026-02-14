import 'package:flutter/material.dart';
import 'package:valentine_app/screens/final_screen.dart';
import 'package:valentine_app/screens/test_screen.dart';
import 'package:valentine_app/screens/verification_screen.dart';
import 'package:valentine_app/theme/app_theme.dart';

void main() {
  runApp(const ValentineApp());
}

class ValentineApp extends StatelessWidget {
  const ValentineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Valentine App',
      theme: AppTheme.lightTheme,
      home: const MainFlow(),
    );
  }
}

class MainFlow extends StatefulWidget {
  const MainFlow({super.key});

  @override
  State<MainFlow> createState() => _MainFlowState();
}

class _MainFlowState extends State<MainFlow> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  void nextPage() {
    if (currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          VerificationScreen(
            onSuccess: nextPage,
          ),
          TestScreen(
            onSuccess: nextPage,
          ),
          const FinalScreen(),
        ],
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  final String subtitle;

  const PlaceholderPage({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 40),
            const Center(
              child: Icon(
                Icons.favorite,
                size: 80,
                color: Color(0xFFFF6F91),
              ),
            ),
          ],
        ),
      ),
    );
  }
}