import 'package:flutter/material.dart';
import 'package:myportfolio/view/about_page.dart';
import 'package:myportfolio/view/contact_view.dart';
import 'package:myportfolio/view/home_view.dart';
import 'package:myportfolio/view/projects_view.dart';
import 'package:provider/provider.dart';

import 'my_theme/app_theme.dart';


void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Joya Kuriakose | Portfolio",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: HomePage(toggleTheme: toggleTheme),
      routes: {
        "/about": (context) => const AboutPage(),
        "/projects": (context) => const ProjectsPage(),
        "/contact": (context) => const ContactPage(),
      },
    );
  }
}