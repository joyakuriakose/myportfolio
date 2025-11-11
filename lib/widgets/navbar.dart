import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onThemeToggle;
  const NavBar({super.key, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.95), // ✅ black background
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.1), // subtle white border
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ---- LEFT: Brand ----
              Text(
                "Joya Kuriakose",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // ✅ white text
                  letterSpacing: 0.5,
                ),
              ),

              // ---- CENTER: Navigation Links ----
              Expanded(
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    alignment: WrapAlignment.center,
                    runSpacing: 4,
                    children: [
                      _navButton(context, "Home", "/"),
                      _navButton(context, "About", "/about"),
                      _navButton(context, "Projects", "/projects"),
                      _navButton(context, "Contact", "/contact"),
                    ],
                  ),
                ),
              ),

              // ---- RIGHT: Social + Theme ----
              Wrap(
                spacing: 4,
                children: [
                  _iconButton(FontAwesomeIcons.github,
                      "https://github.com/joyakuriakose"),
                  _iconButton(FontAwesomeIcons.linkedin,
                      "https://www.linkedin.com/in/joya-kuriakose-b23688196/"),
                  _iconButton(
                      FontAwesomeIcons.envelope, "mailto:joyakuriakose@gmail.com"),
                  IconButton(
                    icon: const Icon(Icons.brightness_6, color: Colors.white),
                    onPressed: onThemeToggle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, String label, String route) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white, // ✅ white button text
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, String url) {
    return IconButton(
      icon: FaIcon(icon, size: 18, color: Colors.white), // ✅ white icons
      onPressed: () => launchUrlString(url),
    );
  }
}
