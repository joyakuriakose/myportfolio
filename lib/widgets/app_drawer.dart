import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _header(context),
            const Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _navItem(context, Icons.home, "Home", "/"),
                  _navItem(context, Icons.person, "About", "/about"),
                  _navItem(context, Icons.work, "Projects", "/projects"),
                  _navItem(context, Icons.mail, "Contact", "/contact"),
                  const Divider(),
                  _socialItem(FontAwesomeIcons.github, "GitHub",
                      "https://github.com/joyakuriakose"),
                  _socialItem(FontAwesomeIcons.linkedin, "LinkedIn",
                      "https://www.linkedin.com/in/joya-kuriakose-b23688196/"),
                  _socialItem(
                      FontAwesomeIcons.envelope, "Email", "mailto:joyakuriakose@gmail.com"),
                  _socialItem(
                      FontAwesomeIcons.phone, "Call", "tel:+917356404519"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: const AssetImage("assets/images/profile.png"),
            onBackgroundImageError: (_, __) {},
            child: const Text(
              "JK",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Joya Kuriakose",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            "Flutter Developer",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, IconData icon, String label, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _socialItem(IconData icon, String label, String url) {
    return ListTile(
      leading: FaIcon(icon, size: 18),
      title: Text(label),
      onTap: () {
        launchUrlString(url);
      },
    );
  }
}
