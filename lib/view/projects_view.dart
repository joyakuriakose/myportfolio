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
    return Scaffold(
      endDrawer: const AppDrawer(),
      body: Stack(children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(top: 80),
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
              githubUrl: p['github']!,
              liveUrl: p['live'], // ✅ safe optional
            ),
          );
        }).toList(),
      );
    });
  }
}
