import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../widgets/app_drawer.dart';
import '../widgets/navbar.dart';
import 'footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                _aboutSection(context),
                const SizedBox(height: 20),
                _skillsSection(context),
                const SizedBox(height: 20),
                _experienceSection(context),
                const SizedBox(height: 20),
                _educationSection(context),
                // ✅ Removed extra 100px gap
                const Footer(), // Footer directly after Education
              ],
            ),
          ),


          /// Fixed Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(onThemeToggle: () {}),
          ),
        ],
      ),
    );
  }

  // ---------------- ABOUT SECTION ------------------
  Widget _aboutSection(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => _aboutContent(context, isMobile: true),
      desktop: (_) => _aboutContent(context),
    );
  }

  Widget _aboutContent(BuildContext context, {bool isMobile = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: isMobile ? 40 : 100,
      ),
      child: Column(
        crossAxisAlignment:
        isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          // ---- Title ----
          Align(
            alignment: isMobile ? Alignment.center : Alignment.centerLeft,
            child: Text(
              "   About Me",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // ---- Row for Image + Text ----
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
            isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              // ✅ Image aligned with text start
              Container(
                width: isMobile ? 140 : 200,
                height: isMobile ? 140 : 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                    image: AssetImage("assets/jpg/joyaphoto.JPG"),
                    fit: BoxFit.contain,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(4, 6),
                    ),
                  ],
                ),
              ),

              if (!isMobile) const SizedBox(width: 50),

              // ✅ Text + Button stacked in a column — aligned perfectly
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: isMobile ? 24 : 0),
                  child: Column(
                    crossAxisAlignment: isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        "I'm Joya Kuriakose, a passionate Flutter Developer with 2+ years of experience "
                            "in building high-performance mobile & web apps using Flutter. I’ve worked on real-world "
                            "products including accommodation apps, field force automation systems, and AMC service apps. "
                            "I focus on clean architecture, scalable UI, and offline-first apps with API integrations.",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          height: 1.6,
                        ),
                        textAlign:
                        isMobile ? TextAlign.center : TextAlign.left,
                      ),
                      const SizedBox(height: 30),

                      // ✅ Resume Button stays aligned with text
                      Align(
                        alignment: isMobile
                            ? Alignment.center
                            : Alignment.centerLeft,
                        child: FilledButton.tonal(
                          onPressed: _openResume,
                          child: const Text("Download Resume"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  // ---------------- SKILLS ------------------
  Widget _skillsSection(BuildContext context) {
    final skills = [
      "Flutter",
      "Dart",
      "REST API",
      "GetX",
      "Provider",
      "Firebase",
      "SQLite",
      "Hive",
      "Google Maps API",
      "Git & GitHub",
      "MVC / MVVM",
      "Responsive UI",
      "Material Design"
    ];

    return Container(
      width: double.infinity,
      color: Colors.grey[300], // ✅ light grey background
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
      child: Column(
        children: [
          Text(
            "Skills",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: skills
                .map(
                  (s) => Chip(
                label: Text(s),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            )
                .toList(),
          )
        ],
      ),
    );
  }

  // ---------------- EXPERIENCE ------------------
  Widget _experienceSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
      child: Column(
        children: [
          Text(
            "Experience",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const CircleAvatar(child: Text("2+")),
            title: const Text("Flutter Developer – Taurus Web Solutions"),
            subtitle: const Text(
                "Oct 2022 – Nov 2024 • Ernakulam, Kerala\n"
                    "Built Flutter apps with REST APIs, Firebase, Offline DB, Google Maps, Play Store & App Store deployment."),
          ),
        ],
      ),

    );
  }

  // ---------------- EDUCATION ------------------
  Widget _educationSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[300], // ✅ light grey background
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
      child: Column(
        children: [
          Text(
            "Education",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const CircleAvatar(child: Text("M")),
            title: const Text("Master of Computer Applications (MCA)"),
            subtitle: const Text(
                "Sree Narayana Gurukulam College • KTU • 2016 – 2018\nGrade: B"),
          ),
        ],
      ),
    );
  }


  void _openResume() {
    launchUrlString(
      "https://drive.google.com/file/d/1Cd8nnyCiXVLqZouj1GYIFhK81C805VTN/view?usp=sharing",
      mode: LaunchMode.externalApplication,
    );
  }
}
