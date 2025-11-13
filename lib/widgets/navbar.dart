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

    return SafeArea(
      bottom: false,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: isMobile ? 22 : 14, // ✅ taller on mobile
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.95),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),

            /// ✅ Responsive layout
            child: isMobile
                ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ===== Row 1: Name + Social Icons =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Joya Kuriakose",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Wrap(
                      spacing: 0,
                      children: [
                        _iconButton(FontAwesomeIcons.github,
                            "https://github.com/joyakuriakose"),
                        _iconButton(
                            FontAwesomeIcons.linkedin,
                            "https://www.linkedin.com/in/joya-kuriakose-b23688196/"),
                        _iconButton(
                            FontAwesomeIcons.envelope,
                            "mailto:joyakuriakose@gmail.com"),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ===== Row 2: Nav Buttons =====
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    _navButton(context, "Home", "/"),
                    _navButton(context, "About", "/about"),
                    _navButton(context, "Projects", "/projects"),
                    _navButton(context, "Contact", "/contact"),
                  ],
                ),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ---- LEFT: Brand ----
                Text(
                  "Joya Kuriakose",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),

                // ---- CENTER: Navigation ----
                Wrap(
                  spacing: 20,
                  children: [
                    _navButton(context, "Home", "/"),
                    _navButton(context, "About", "/about"),
                    _navButton(context, "Projects", "/projects"),
                    _navButton(context, "Contact", "/contact"),
                  ],
                ),

                // ---- RIGHT: Social + Theme ----
                Wrap(
                  spacing: 6,
                  children: [
                    _iconButton(FontAwesomeIcons.github,
                        "https://github.com/joyakuriakose"),
                    _iconButton(
                        FontAwesomeIcons.linkedin,
                        "https://www.linkedin.com/in/joya-kuriakose-b23688196/"),
                    _iconButton(FontAwesomeIcons.envelope,
                        "mailto:joyakuriakose@gmail.com"),
                    IconButton(
                      icon: const Icon(Icons.brightness_6,
                          color: Colors.white),
                      onPressed: onThemeToggle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ Navigation Button with Active Highlight
  Widget _navButton(BuildContext context, String label, String route) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final bool isSelected = currentRoute == route;

    return TextButton(
      onPressed: () {
        if (currentRoute != route) {
          Navigator.pushNamed(context, route);
        }
      },
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          color: isSelected ? Colors.cyan : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          fontSize: 15,
          // decoration:
          // isSelected ? TextDecoration.none: TextDecoration.none,
          // decorationColor: Colors.cyan,
        ),
        child: Text(label),
      ),
    );
  }

  /// ✅ Social Icons
  Widget _iconButton(IconData icon, String url) {
    return IconButton(
      icon: FaIcon(icon, size: 18, color: Colors.white),
      onPressed: () => launchUrlString(url, mode: LaunchMode.externalApplication),
    );
  }
}
