import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../widgets/app_drawer.dart';
import '../widgets/navbar.dart';
import '../widgets/project_card.dart';
import 'footer.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  final List<Map<String, String>> _projects = const [
    {
      "title": "Waves - Pavithram",
      "description":
      "It's a field sales/ field operations app used by employees to plan and track "
          "daily works, route plans, reports and more  ",
      "tech": "Flutter • Block",
      "playstore": "https://play.google.com/store/apps/details?id=com.spiralcode.waves2",
      "live": "https://docs.google.com/document/d/17wX6KtVlcAnulaBxBK59VNboqe_aNfRZ5QSkO6yEhW8/edit?usp=sharing",
      // "image": "assets/images/projects/tips_and_plans.png"
    },
    {
      "title": "Waves - Sithas ",
      "description":
      "Sales management system that helps field sales representatives manage their daily "
          "operations efficiently- app includes features • sales management • payment collection • "
          "lead managemt • invoice management • Returns • Stock transfer and more.",
      "tech": "Flutter • Riverpod",
     // "github": "https://github.com/joyakuriakose/serviceapp",
      "live": "https://docs.google.com/document/d/1yBi0TlMuJ7TJ-CJL7tun7QV5gzNWNDuQ5Xmo8-2FI-c/edit?usp=sharing",
      // "image": "assets/images/projects/tips_and_plans.png"
    },
    {
      "title": "Ozone - Sales Tracker",
      "description":
      "Offline first sales tracking and location monitoring application designed for field sales teams.",
      "tech": "Flutter • Riverpod",
     // "github": "https://github.com/joyakuriakose/serviceapp",
      "live": "https://docs.google.com/document/d/1vKPklQPqSl8vbhKBltsw4mYQpjYjQ5kqvbGlf6b3dPs/edit?usp=sharing",
      // "image": "assets/images/projects/tips_and_plans.png"
    },
    {
      "title": "Tips & Plans",
      "description":
      "AC AMC & service management app - request AMC, track service status, get notifications and submit feedback.",
      "tech": "Flutter • GetX",
      "github": "https://github.com/joyakuriakose/serviceapp",
      "live": "https://docs.google.com/document/d/1kf_vol7YDK9O_pnJ5ORnvSnS7BN38IDWoBznbXIolKU/edit?usp=sharing",
      // "image": "assets/images/projects/tips_and_plans.png"
    },
    {
      "title": "Smart Taurus",
      "description":
      "B2B Sales & Field Force Automation app for managing leads, orders, attendance and sales reports (offline sync).",
      "tech": "Flutter • GetX",
      "github": "https://github.com/joyaktaurus/smart_taurus",
      //"live": "https://smarttaurus-demo.web.app",
      // "image": "assets/images/projects/smart_taurus.png"
    },
    {
      "title": "Feel At Home",
      "description":
      "Student relocation & accommodation booking app with property listings, chat support, complaints and notifications.",
      "tech": "Flutter • Provider",
      "github": "https://github.com/joyaktaurus/feel_latest",
    //  "live": "https://feelathome-demo.web.app",
    //  "image": "assets/images/projects/feel_at_home.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;

    return Scaffold(
      endDrawer: const AppDrawer(),
      body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: isMobile ? 150: 80, // ✅ more space on mobile
                             ),
          child: Column(
            children: [
              _header(context),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _projectsGrid(context),
              ),
              const SizedBox(height: 80),
              const Footer(),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: NavBar(onThemeToggle: () {}),
        ),
      ]),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Projects", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            "A selection of production-level mobile apps built using Flutter.",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _projectsGrid(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => _buildGrid(context, 1),
      tablet: (_) => _buildGrid(context, 2),
      desktop: (_) => _buildGrid(context, 3),
    );
  }

  Widget _buildGrid(BuildContext context, int crossAxisCount) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final itemWidth = (width - (16 * (crossAxisCount - 1))) / crossAxisCount;
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: _projects.map((p) {
          return SizedBox(
            width: itemWidth.clamp(280, 420),
            child: ProjectCard(
              title: p['title']!,
              description: p['description']!,
              tech: p['tech']!,
              githubUrl: p['github'],
              liveUrl: p['live'],
              playstore: p['playstore'],
            ),
          );
        }).toList(),
      );
    });
  }
}
