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
            child: const Text(
              "Flutter Developer | 3.3 Years Experience",
              key: Key('heroSubtitle'),
              style: TextStyle(fontSize: 24),
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
    return FadeInLeft(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "About Me",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "I am a passionate Flutter Developer with 3+ years of professional experience crafting pixel-perfect, high-performance mobile applications. Adept in Dart and Flutter architecture patterns, I focus on delivering smooth user experiences with efficient code. I've played a significant role in building and maintaining enterprise-level apps like SBI YONO 2.0. Skilled in integrating REST APIs, Firebase, and platform services, I prioritize writing clean, scalable, and testable code.",
              style: TextStyle(fontSize: 18),
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
        color: const Color(0xFF1C1F26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Experience",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Tata Consultancy Services | Dec 2021 - Present\n- Flutter Developer\n- Successfully contributed to the SBI YONO 2.0 mobile banking project for the State Bank of India.\n- Built scalable and secure cross-platform mobile applications using Flutter and MobX.\n- Applied clean architecture principles for maintainable and testable code.\n- Integrated RESTful APIs, Firebase, and ensured security compliance for financial transactions.\n- Conducted unit testing and peer code reviews to ensure code quality and performance.\n- Actively collaborated in Agile ceremonies including sprint planning, reviews, and retrospectives.",
              style: TextStyle(fontSize: 18),
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
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Projects",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: const [
                  ProjectCard(
                    title: "SBI YONO 2.0",
                    description:
                        "An advanced mobile banking application developed for the State Bank of India. Created using Flutter with MobX for state management, the app delivers fast, secure, and user-friendly banking experiences. Key responsibilities included UI implementation, API integration, state management with MobX, and collaboration with cross-functional teams to meet business goals.",
                  ),
                ],
              ),
            ),
          ],
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
        color: const Color(0xFF22252C),
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
