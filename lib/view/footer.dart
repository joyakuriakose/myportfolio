import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          // 🌫 Soft glowing effect from sides
          BoxShadow(
            color: Colors.white.withAlpha((0.25 * 255).round()), // replaces withOpacity
            blurRadius: 25,
            spreadRadius: 8,
            offset: const Offset(0, 0),
          ),
          // 👉 If you prefer color glow (try uncommenting below line)
          BoxShadow(
            color: Colors.white.withAlpha((0.25 * 255).round()), // replaces withOpacity
            blurRadius: 25,
            spreadRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 16,
            children: [
              _iconButton(FontAwesomeIcons.github,
                  Uri.parse("https://github.com/joyakuriakose")),
              _iconButton(FontAwesomeIcons.linkedin,
                  Uri.parse("https://www.linkedin.com/in/joya-kuriakose-b23688196/")),
              _iconButton(FontAwesomeIcons.envelope,
                  Uri.parse("mailto:joyakuriakose@gmail.com")),
              _iconButton(FontAwesomeIcons.phone,
                  Uri.parse("tel:+917356404519")),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            "© $year Joya Kuriakose • Built with Flutter",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, Uri url) {
    return IconButton(
      icon: FaIcon(icon, size: 22, color: Colors.white),
      hoverColor: Colors.white24,
      onPressed: () async {
        if (!await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: '_blank',
        )) {
          debugPrint('❌ Could not launch $url');
        }
      },
    );
  }
}
