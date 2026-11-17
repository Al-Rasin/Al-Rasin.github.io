import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/entry.dart';
import '../widgets/screenshots.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final main = PortfolioData.projects.where((p) => !p.learning);
    final learning = PortfolioData.projects.where((p) => p.learning);
    return Section(
      index: '02',
      title: 'Side projects',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (i, p) in main.indexed)
            NumberedEntry(
              number: i + 1,
              title: p.title,
              subtitle: p.subtitle,
              body: p.description,
              tech: p.tech,
              images: p.screenshots,
              links: [TextLink('Source on GitHub', url: p.url)],
            ),
          Text(
            'Earlier, while learning Flutter',
            style: AppText.lead.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 20),
          for (final p in learning) _LearningLine(p),
        ],
      ),
    );
  }
}

class _LearningLine extends StatelessWidget {
  const _LearningLine(this.p);

  final Project p;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Wrap(
        spacing: 16,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          TextLink(p.title, url: p.url),
          Text(p.description, style: AppText.small),
          if (p.screenshots.isNotEmpty)
            TextLink(
              'screens',
              style: AppText.small,
              onTap: () => showScreenshots(context, p.screenshots, 0),
            ),
        ],
      ),
    );
  }
}
