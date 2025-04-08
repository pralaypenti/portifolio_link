import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portifolio_link/portifolio.dart';

void main() {
  setUpAll(() {
    // Animation control is not mandatory due to pumpAndSettle()
    // but we can still consider disabling if needed
  });

  testWidgets('HeroSection displays title and subtitle', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HeroSection()));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('heroTitle')), findsOneWidget);
    expect(find.text("Hi, I'm Pralay Penti"), findsOneWidget);
    expect(find.byKey(const Key('heroSubtitle')), findsOneWidget);
    expect(
      find.text("Flutter Developer | 3.3 Years Experience"),
      findsOneWidget,
    );
  });

  testWidgets('AboutSection contains heading and description', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AboutSection()));
    await tester.pumpAndSettle();
    expect(find.text("About Me"), findsOneWidget);
    expect(
      find.textContaining(
        "I am a passionate Flutter Developer with 3+ years of professional experience crafting pixel-perfect, high-performance mobile applications. Adept in Dart and Flutter architecture patterns, I focus on delivering smooth user experiences with efficient code. I've played a significant role in building and maintaining enterprise-level apps like SBI YONO 2.0. Skilled in integrating REST APIs, Firebase, and platform services, I prioritize writing clean, scalable, and testable code.",
      ),
      findsOneWidget,
    );
  });

  testWidgets('ExperienceSection has job title and details', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ExperienceSection()));
    await tester.pumpAndSettle();
    expect(find.text("Experience"), findsOneWidget);
    expect(find.textContaining("Tata Consultancy Services"), findsOneWidget);
    expect(find.textContaining("SBI YONO 2.0"), findsOneWidget);
  });

  testWidgets('ProjectsSection displays project title and description', (
    WidgetTester tester,
  ) async {
    // Wrap with Scaffold and SingleChildScrollView to avoid RenderFlex overflow in test env
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: ProjectsSection())),
      ),
    );

    await tester.pumpAndSettle(); // Ensure animations complete

    // Section title
    expect(find.text("Projects"), findsOneWidget);

    // Project title using key and exact match
    expect(find.byKey(const Key('projectTitle')), findsOneWidget);
    expect(find.text("SBI YONO 2.0"), findsOneWidget);

    // Project description using key and full content
    expect(find.byKey(const Key('projectDescription')), findsOneWidget);
    expect(
      find.text(
        "An advanced mobile banking application developed for the State Bank of India. Created using Flutter with MobX for state management, the app delivers fast, secure, and user-friendly banking experiences. Key responsibilities included UI implementation, API integration, state management with MobX, and collaboration with cross-functional teams to meet business goals.",
      ),
      findsOneWidget,
    );
  });

  testWidgets('ContactSection shows phone and email', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ContactSection()));
    await tester.pumpAndSettle();
    expect(find.text("Contact Me"), findsOneWidget);
    expect(find.text("📞 +91-7036702499"), findsOneWidget);
    expect(find.text("✉️ pralaypenti3@gmail.com"), findsOneWidget);
  });
  testWidgets('SkillsSection displays correctly without overflow', (WidgetTester tester) async {
  // Build widget with sufficient space
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView( // Add scrolling to prevent overflow
          child: SkillsSection(),
        ),
      ),
    ),
  );

  await tester.pumpAndSettle();

  // Verify title
  final titleFinder = find.text('Languages, Tools & Frameworks');
  expect(titleFinder, findsOneWidget);

  // Verify categories
  final expectedCategories = [
    "Languages", "Frameworks", "State Management",
    "Tools & Platforms", "Cloud & Backend",
  ];
  
  for (final category in expectedCategories) {
    expect(find.text(category), findsOneWidget);
  }

  // Verify skills
  final expectedSkills = [
    "Dart", "MobX", "Android Studio", "VS Code",
    "Git", "Postman", "Figma", "Firebase", "REST APIs",
  ];
  
  for (final skill in expectedSkills) {
    expect(find.text(skill), findsOneWidget);
  }

  // Verify no overflow errors
  expect(tester.takeException(), isNull, 
      reason: 'Overflow error detected in layout');
});
}
