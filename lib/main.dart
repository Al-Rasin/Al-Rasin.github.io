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
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: SingleChildScrollView(
          child: ContentWidth(
            child: Padding(
              padding: EdgeInsets.only(top: isNarrow(context) ? 56 : 96),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const IntroSection(),
                  const ExperienceSection(),
                  const ProjectsSection(),
                  if (PortfolioData.blogPosts.isNotEmpty) const BlogSection(),
                  const ToolsSection(),
                  const ContactSection(),
                  const Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
