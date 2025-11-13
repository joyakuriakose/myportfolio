import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../widgets/app_drawer.dart';
import '../widgets/navbar.dart';
import 'footer.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const HomePage({super.key, required this.toggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2100),
    );

    // ✅ Right → Left animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.9, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.width < 700 ? 150 : 80, // ✅ taller on mobile
        ),
        child: NavBar(onThemeToggle: widget.toggleTheme),
      ),

      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            // ✅ Subtle black gradient only on left side
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black54, // left shadow
                Colors.transparent, // fade to normal
              ],
              stops: [0.0, 0.5],
            ),
          ),
          child: Center(
            child: Container(
              alignment: Alignment.topLeft,
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _heroSection(context),
                  const SizedBox(height: 100),

                  /// ✅ Footer centered horizontally
                  const Center(child: Footer()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Responsive Hero Section
  Widget _heroSection(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (ctx) => _buildAnimatedContent(ctx, isMobile: true),
      tablet: (ctx) => _buildAnimatedContent(ctx, isMobile: true),
      desktop: (ctx) => _buildAnimatedContent(ctx),
    );
  }

  /// Animated Content (Right → Left)
  Widget _buildAnimatedContent(BuildContext context, {bool isMobile = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 120,
        vertical: isMobile ? 40 : 120,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: child,
            ),
          );
        },
        child: Column(
          crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, I'm",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.black),
            ),
            Text(
              "Joya Kuriakose",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
            Text(
              "Flutter Developer | Mobile & Web Apps",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
            const SizedBox(height: 28),

            /// Buttons
            Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment:
              isMobile ? WrapAlignment.center : WrapAlignment.start,
              children: [
                FilledButton(
                  onPressed: () => Navigator.pushNamed(context, "/projects"),
                  child: const Text("View Projects"),
                ),
                OutlinedButton(
                  onPressed: _launchResume,
                  child: const Text("Download Resume"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchResume() {
    launchUrlString(
      "https://drive.google.com/file/d/1Cd8nnyCiXVLqZouj1GYIFhK81C805VTN/view?usp=sharing",
      mode: LaunchMode.externalApplication,
    );
  }
}
