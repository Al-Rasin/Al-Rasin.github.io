import 'package:flutter/material.dart';

import 'data/portfolio_data.dart';
import 'sections/blog_section.dart';
import 'sections/contact_section.dart';
import 'sections/hero_section.dart';
import 'sections/live_apps_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'theme/app_theme.dart';
import 'widgets/common.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${PortfolioData.name} — ${PortfolioData.role}',
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
  final _workKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _blogKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
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
          child: Column(
            children: [
              _NavBar(
                onWork: () => _scrollTo(_workKey),
                onSkills: () => _scrollTo(_skillsKey),
                onBlog: () => _scrollTo(_blogKey),
                onContact: () => _scrollTo(_contactKey),
              ),
              HeroSection(
                onSeeWork: () => _scrollTo(_workKey),
                onContact: () => _scrollTo(_contactKey),
              ),
              LiveAppsSection(key: _workKey),
              const ProjectsSection(),
              if (PortfolioData.blogPosts.isNotEmpty)
                BlogSection(key: _blogKey),
              SkillsSection(key: _skillsKey),
              ContactSection(key: _contactKey),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({
    required this.onWork,
    required this.onSkills,
    required this.onBlog,
    required this.onContact,
  });

  final VoidCallback onWork;
  final VoidCallback onSkills;
  final VoidCallback onBlog;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: ContentWidth(
        child: SizedBox(
          height: 68,
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.borderHover),
                  image: const DecorationImage(
                    image: AssetImage(PortfolioData.photo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                PortfolioData.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
              const Spacer(),
              _NavLink('Work', onWork),
              if (PortfolioData.blogPosts.isNotEmpty) _NavLink('Blog', onBlog),
              if (!narrow) _NavLink('Stack', onSkills),
              const SizedBox(width: 8),
              AppButton(label: 'Contact', small: true, onPressed: onContact),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink(this.label, this.onTap);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.muted,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      child: Text(label),
    );
  }
}
