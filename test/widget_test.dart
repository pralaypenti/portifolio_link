import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portifolio_link/portifolio.dart';

void main() {
  setUpAll(() {});

  testWidgets('HeroSection displays title and dynamic subtitle', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HeroSection()));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('heroTitle')), findsOneWidget);
    expect(find.text("Hi, I'm Pralay Penti"), findsOneWidget);

    expect(find.byKey(const Key('heroSubtitle')), findsOneWidget);

    final joiningDate = DateTime(2021, 12, 16);
    final now = DateTime.now();

    int totalMonths =
        (now.year - joiningDate.year) * 12 + (now.month - joiningDate.month);
    if (now.day >= joiningDate.day) {
      totalMonths += 1;
    }
    double experience = totalMonths / 12.0;
    final expectedSubtitle =
        "Flutter Developer | ${experience.toStringAsFixed(1)} Years Experience";

    expect(find.text(expectedSubtitle), findsOneWidget);
  });

  testWidgets('AboutSection renders with correct title and experience', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AboutSection())),
    );
    await tester.pumpAndSettle();

    expect(find.text('About Me'), findsOneWidget);

    expect(
      find.textContaining('I am a passionate Flutter Developer'),
      findsOneWidget,
    );
    expect(find.textContaining('years of experience'), findsOneWidget);

    final pattern = RegExp(r'\d+(\.\d+)? years of experience');
    final matches = find.byWidgetPredicate(
      (widget) => widget is Text && pattern.hasMatch(widget.data ?? ''),
    );
    expect(matches, findsOneWidget);
  });

  testWidgets('ExperienceSection has job title and details', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ExperienceSection()));
    await tester.pumpAndSettle();

    expect(find.text("Experience"), findsOneWidget);
    expect(find.textContaining("Tata Consultancy Services"), findsOneWidget);
    expect(find.textContaining("SBI"), findsOneWidget);
  });

  testWidgets('ProjectsSection renders all ProjectCards', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: ProjectsSection())),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Projects'), findsOneWidget);

    expect(find.text('ICICI Bank App'), findsOneWidget);
    expect(
      find.textContaining(
        'Responsible for designing and developing common reusable widgets',
      ),
      findsOneWidget,
    );

    expect(find.text('SBI YONO 2.0'), findsOneWidget);
    expect(
      find.textContaining('Contributed to the State Bank of India'),
      findsOneWidget,
    );

    expect(find.byType(ProjectCard), findsNWidgets(2));
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
  testWidgets('SkillsSection displays correctly without overflow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: SkillsSection())),
      ),
    );

    await tester.pumpAndSettle();

    final titleFinder = find.text('Languages, Tools & Frameworks');
    expect(titleFinder, findsOneWidget);

    final expectedCategories = [
      "Languages",
      "Frameworks",
      "State Management",
      "Tools & Platforms",
      "Cloud & Backend",
    ];

    for (final category in expectedCategories) {
      expect(find.text(category), findsOneWidget);
    }

    final expectedSkills = [
      "Dart",
      "MobX",
      "Android Studio",
      "VS Code",
      "Git",
      "Postman",
      "Figma",
      "Firebase",
      "REST APIs",
    ];

    for (final skill in expectedSkills) {
      expect(find.text(skill), findsOneWidget);
    }

    expect(
      tester.takeException(),
      isNull,
      reason: 'Overflow error detected in layout',
    );
  });
  test('calculateExperience returns correct experience string', () {
    final joiningDate = DateTime(2021, 12, 16);
    final expected = calculateExperience(joiningDate: joiningDate);
    final now = DateTime.now();

    int totalMonths =
        (now.year - joiningDate.year) * 12 + (now.month - joiningDate.month);
    if (now.day >= joiningDate.day) totalMonths++;
    double exp = totalMonths / 12;

    expect(expected, exp.toStringAsFixed(1));
  });
  testWidgets('ProjectCard renders title and description', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProjectCard(
          title: 'Test Project',
          description: 'A description of the test project.',
        ),
      ),
    );

    expect(find.text('Test Project'), findsOneWidget);
    expect(find.text('A description of the test project.'), findsOneWidget);
  });
  testWidgets('CertificatesSection displays titles and issuers only', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: CertificatesSection())),
    );

    await tester.pump();
    await tester.pump(Duration(seconds: 3));

    expect(find.text("Licenses & Certifications"), findsOneWidget);

    expect(find.text('Flutter - Beginner course'), findsOneWidget);
    expect(
      find.text('Flutter Essential Training: Build for Multiple Platforms'),
      findsOneWidget,
    );
    expect(find.text('Flutter for Beginners using Dart'), findsOneWidget);

    expect(find.text('Udemy'), findsOneWidget);
    expect(find.text('LinkedIn'), findsOneWidget);
    expect(find.text('MindLuster'), findsOneWidget);

    expect(find.textContaining('title:'), findsNothing);
    expect(find.textContaining('Issued'), findsNothing);
  });

  testWidgets('Contact form renders input fields and button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ContactFormSection())),
    );

    await tester.pumpAndSettle();

    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Message'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.text('Send Message'), findsOneWidget);
  });

  testWidgets('Form shows validation errors when fields are empty', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ContactFormSection())),
    );

    await tester.pumpAndSettle();

    final button = find.text('Send Message');
    await tester.tap(button);
    await tester.pump();

    expect(find.text('Please enter Name'), findsOneWidget);
    expect(find.text('Please enter Email'), findsOneWidget);
    expect(find.text('Please enter Message'), findsOneWidget);
  });

  testWidgets('Form shows email validation error on invalid email', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ContactFormSection())),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
    await tester.enterText(find.byType(TextFormField).at(1), 'invalidemail');
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'This is a message.',
    );

    final button = find.text('Send Message');
    await tester.tap(button);
    await tester.pump();

    expect(find.text('Enter a valid email'), findsOneWidget);
  });

  group('PortfolioHomePage Widget Tests', () {
    late Widget homePage;

    setUp(() {
      homePage = const MaterialApp(home: PortfolioHomePage());
    });

    testWidgets('Tapping hamburger shows overlay menu', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(homePage);

      final scrollView = find.byKey(PortfolioHomePage.scrollViewKey);
      await tester.drag(scrollView, const Offset(0, -300));
      await tester.pump();

      await tester.tap(find.byKey(PortfolioHomePage.hamburgerButtonKey));
      await tester.pumpAndSettle();

      expect(find.byType(AnimatedPositioned), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('Menu closes when tapping close icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(homePage);

      final scrollView = find.byKey(PortfolioHomePage.scrollViewKey);
      await tester.drag(scrollView, const Offset(0, -300));
      await tester.pump();

      await tester.tap(find.byKey(PortfolioHomePage.hamburgerButtonKey));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsNothing);
    });

    testWidgets('Tapping a menu item scrolls to the section and closes menu', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(homePage);

      final scrollView = find.byKey(PortfolioHomePage.scrollViewKey);
      await tester.drag(scrollView, const Offset(0, -300));
      await tester.pump();

      await tester.tap(find.byKey(PortfolioHomePage.hamburgerButtonKey));
      await tester.pumpAndSettle();

      await tester.tap(find.text('About'));
      await tester.pumpAndSettle();

      expect(find.text('About'), findsNothing); 
    });

    testWidgets('Menu overlay has correct structure', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(homePage);

      final scrollView = find.byKey(PortfolioHomePage.scrollViewKey);
      expect(scrollView, findsOneWidget);

      await tester.drag(scrollView, const Offset(0, -500));
      await tester.pumpAndSettle();

      final hamburgerButton = find.byKey(PortfolioHomePage.hamburgerButtonKey);
      expect(hamburgerButton, findsOneWidget);

      await tester.tap(hamburgerButton);
      await tester.pumpAndSettle();

      expect(find.byType(AnimatedPositioned), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);

      expect(
        find.widgetWithText(TextButton, 'Drop Me a Message'),
        findsOneWidget,
      );
    });
  });
}
