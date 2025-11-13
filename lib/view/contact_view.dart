import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/app_drawer.dart';
import '../widgets/navbar.dart';
import 'footer.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  bool _loading = false;

  final String web3FormKey = "5e44e805-82c4-4699-8db0-9290972057f9";

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    const url = "https://api.web3forms.com/submit";
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "access_key": web3FormKey,
        "name": _name.text,
        "email": _email.text,
        "message": _message.text,
      }),
    );

    setState(() => _loading = false);

    if (response.statusCode == 200) {
      _name.clear();
      _email.clear();
      _message.clear();
      _showDialog(success: true);
    } else {
      _showDialog(success: false);
    }
  }

  void _showDialog({required bool success}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(success ? "✅ Message Sent" : "❌ Failed"),
        content: Text(success
            ? "Thank you! I will get back to you shortly."
            : "Something went wrong. Please try again later."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

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
                _contactSection(context),
                const SizedBox(height: 100),
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
        ],
      ),
    );
  }

  Widget _contactSection(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => _formLayout(context, isMobile: true),
      desktop: (_) => _formLayout(context),
    );
  }

  Widget _formLayout(BuildContext context, {bool isMobile = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 200,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment:
        isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Me",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Have a project or want to connect? Feel free to reach out!",
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
          const SizedBox(height: 40),

          Form(
            key: _formKey,
            child: Column(
              children: [
                _inputField("Full Name", _name),
                const SizedBox(height: 16),
                _inputField("Email", _email, email: true),
                const SizedBox(height: 16),
                _inputField("Message", _message, maxLines: 5),
                const SizedBox(height: 30),

                _loading
                    ? const CircularProgressIndicator()
                    : FilledButton(
                  onPressed: _submitForm,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    child: Text("Send Message"),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),
          _contactInfo(context),
        ],
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller,
      {bool email = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) return "Required field";
        if (email && !value.contains("@")) return "Invalid email";
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _contactInfo(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 40),
        Text("You can also reach me at:",
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        SelectableText("📧 joyakuriakose@gmail.com"),
        SelectableText("📞 +91 7356404519"),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () =>
              launchUrlString("mailto:joyakuriakose@gmail.com"),
          child: const Text("Send Email"),
        )
      ],
    );
  }
}
