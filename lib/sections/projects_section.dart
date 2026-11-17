import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/screenshots.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final main = PortfolioData.projects.where((p) => !p.learning);
    final learning = PortfolioData.projects.where((p) => p.learning);
    return Section(
      title: 'Side projects',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (i, p) in main.indexed) ...[
            if (i > 0) const SizedBox(height: 48),
            _Project(p),
          ],
          const SizedBox(height: 56),
          Text('Earlier, while learning Flutter', style: AppText.sectionTitle),
          const SizedBox(height: 16),
          for (final p in learning) _LearningLine(p),
        ],
      ),
    );
  }
}

class _Project extends StatelessWidget {
  const _Project(this.p);

  final Project p;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextLink(p.title, url: p.url, style: AppText.itemTitle),
        const SizedBox(height: 10),
        Text(p.description, style: AppText.body),
        const SizedBox(height: 8),
        Text(p.tech, style: AppText.code),
        if (p.screenshots.isNotEmpty) ...[
          const SizedBox(height: 16),
          ScreenshotRow(images: p.screenshots),
        ],
      ],
    );
  }
}

class _LearningLine extends StatelessWidget {
  const _LearningLine(this.p);

  final Project p;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Wrap(
        spacing: 14,
        runSpacing: 4,
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
