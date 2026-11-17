import 'package:flutter/material.dart';

import 'data/portfolio_data.dart';
import 'sections/blog_section.dart';
import 'sections/contact_section.dart';
import 'sections/experience_section.dart';
import 'sections/intro_section.dart';
import 'sections/projects_section.dart';
import 'theme/app_theme.dart';
import 'widgets/common.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${PortfolioData.name}, mobile app developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scroll = ScrollController();
  final _keys = {
    'work': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _jump(String id) {
    final ctx = _keys[id]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          controller: _scroll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PageWidth(child: TopBar(onJump: _jump)),
              const PageWidth(child: HeroSection()),
              SizedBox(height: isNarrow(context) ? 56 : 96),
              PhoneStrip(scroll: _scroll),
              PageWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExperienceSection(key: _keys['work']),
                    ProjectsSection(key: _keys['projects']),
                    if (PortfolioData.blogPosts.isNotEmpty) const BlogSection(),
                    const ToolsSection(),
                    ContactSection(key: _keys['contact']),
                    const Footer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
