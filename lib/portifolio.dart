import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:io';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pralay Penti Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatelessWidget {
  const PortfolioHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HeroSection(),
            AboutSection(),
            ExperienceSection(),
            SkillsSection(),
            ProjectsSection(),
            CertificatesSection(),
            ContactSection(),
          ],
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final experience = calculateExperience(joiningDate: DateTime(2021, 12, 16));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            child: const Text(
              "Hi, I'm Pralay Penti",
              key: Key('heroTitle'),
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            child: Text(
              "Flutter Developer | $experience Years Experience",
              key: const Key('heroSubtitle'),
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final experience = calculateExperience(joiningDate: DateTime(2021, 12, 16));

    return FadeInLeft(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Me",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "I am a passionate Flutter Developer with $experience years of experience building robust, scalable, and performant mobile applications. "
              "I specialize in cross-platform development, state management, and API integration. "
              "I love turning complex problems into elegant solutions and continuously improving my skills in Dart, Flutter, and modern app architectures.",
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Experience",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Tata Consultancy Services | Dec 2021 - Present\n\n'
              '- Role: Flutter Developer\n'
              '- Delivered high-performance mobile apps for enterprise banking clients including ICICI and SBI.\n'
              '- Implemented scalable and maintainable codebases using Flutter and MobX state management.\n'
              '- Integrated RESTful APIs and optimized app performance.\n'
              '- Collaborated in Agile teams to ensure timely delivery and high code quality.\n'
              '- Contributed to reusable component libraries for consistent UI across platforms.',
              style: TextStyle(fontSize: 18, height: 1.5, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Projects",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ProjectCard(
                title: "ICICI Bank App",
                description:
                    "Responsible for designing and developing common reusable widgets used across all modules in the app. "
                    "Implemented scalable and maintainable UI components to ensure consistency and reduce development time. "
                    "Utilized MobX for efficient state management and handled dynamic UI updates for a seamless user experience.",
              ),
              ProjectCard(
                title: "SBI YONO 2.0",
                description:
                    "Contributed to the State Bank of India’s mobile banking app, focusing on the loan journey. "
                    "Implemented features like loan applications, eligibility checks, interest calculators, and sanction letter management. "
                    "Used MobX for efficient state management to keep UI logic clean and maintainable.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            key: const Key('projectTitle'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(description, key: const Key('projectDescription')),
        ],
      ),
    );
  }
}

bool get isInTest => Platform.environment.containsKey('FLUTTER_TEST');

Future<void> _launchUrl(Uri uri) async {
  try {
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: kIsWeb ? '_blank' : null,
    )) {
      debugPrint('Could not launch $uri');
    }
  } catch (e) {
    debugPrint('Exception when launching $uri: $e');
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Contact Me",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap:
                  () => _launchUrl(Uri(scheme: 'tel', path: '+917036702499')),
              child: const Text(
                "📞 +91-7036702499",
                style: TextStyle(fontSize: 18, color: Colors.blueAccent),
              ),
            ),
            GestureDetector(
              onTap:
                  () => _launchUrl(
                    Uri(scheme: 'mailto', path: 'pralaypenti3@gmail.com'),
                  ),
              child: const Text(
                "✉️ pralaypenti3@gmail.com",
                style: TextStyle(fontSize: 18, color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            child: const Text(
              'Languages, Tools & Frameworks',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSkillsGrid(),
        ],
      ),
    );
  }

  Widget _buildSkillsGrid() {
    final skillsData = {
      'Languages': ['Dart'],
      'Frameworks': ['Flutter'],
      'State Management': ['MobX'],
      'Tools & Platforms': [
        'VS Code',
        'Android Studio',
        'Git',
        'Postman',
        'Figma',
      ],
      'Cloud & Backend': ['Firebase', 'REST APIs'],
    };

    return FadeInUp(
      child: Wrap(
        spacing: 16,
        runSpacing: 24,
        children:
            skillsData.entries.map((entry) {
              return _buildSkillCategory(entry.key, entry.value);
            }).toList(),
      ),
    );
  }

  Widget _buildSkillCategory(String title, List<String> skills) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) => SkillChip(label: skill)).toList(),
          ),
        ],
      ),
    );
  }
}

class SkillChip extends StatelessWidget {
  final String label;

  const SkillChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

String calculateExperience({required DateTime joiningDate}) {
  final now = DateTime.now();

  int totalMonths =
      (now.year - joiningDate.year) * 12 + (now.month - joiningDate.month);

  if (now.day >= joiningDate.day) {
    totalMonths += 1;
  }

  double experience = totalMonths / 12;

  return experience.toStringAsFixed(1);
}

class Certificate {
  final String title;
  final String issuer;

  Certificate({required this.title, required this.issuer});
}

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Certificate> certificates = [
      Certificate(title: 'Flutter - Beginner course', issuer: 'Udemy'),
      Certificate(
        title: 'Flutter Essential Training: Build for Multiple Platforms',
        issuer: 'LinkedIn',
      ),
      Certificate(
        title: 'Flutter for Beginners using Dart',
        issuer: 'MindLuster',
      ),
    ];

    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Licenses & Certifications",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ...certificates.map(
              (cert) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cert.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      cert.issuer,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
