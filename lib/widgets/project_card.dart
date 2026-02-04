import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String tech;
  final String? playstore; // ✅ optional
  final String? githubUrl; // ✅ optional
  final String? liveUrl; // ✅ optional

  const ProjectCard({
    super.key,
    required this.title,
    this.playstore,
    required this.description,
    required this.tech,
    this.githubUrl,
    this.liveUrl,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        transform: _hover
            ? (Matrix4.identity()..translate(0, -6, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hover ? 0.14 : 0.06),
              blurRadius: _hover ? 18 : 10,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: theme.dividerColor.withOpacity(0.06)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _contentSection(theme),
        ),
      ),
    );
  }

  Widget _contentSection(ThemeData theme) {
    final hasLive = widget.liveUrl != null && widget.liveUrl!.isNotEmpty;
    final hasGithub = widget.githubUrl != null && widget.githubUrl!.isNotEmpty;
    final playStore = widget.playstore != null && widget.playstore!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style:
          theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          widget.tech,
          style: theme.textTheme.bodySmall?.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.description,
          style: theme.textTheme.bodyMedium,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16),

        // ✅ Buttons Wrap
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (hasLive)
              ElevatedButton.icon(
                onPressed: () => _openUrl(widget.liveUrl!),
                icon: const FaIcon(FontAwesomeIcons.globe, size: 14),
                label: const Text("Sample View"),
              ),
            if (playStore)
              ElevatedButton.icon(
                onPressed: () => _openUrl(widget.playstore!),
                icon: const FaIcon(FontAwesomeIcons.googlePlay, size: 14),
                label: const Text("Play Store"),
              ),
            if (hasGithub)
              OutlinedButton.icon(
                onPressed: () => _openUrl(widget.githubUrl!),
                icon: const FaIcon(FontAwesomeIcons.github, size: 14),
                label: const Text("GitHub"),
              ),
          ],
        ),
      ],
    );
  }

  void _openUrl(String url) async {
    if (url.isEmpty) return;
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}
