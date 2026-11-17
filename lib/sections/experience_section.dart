import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/screenshots.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      title: 'Work',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (i, job) in PortfolioData.experience.indexed) ...[
            if (i > 0) const SizedBox(height: 48),
            _Job(job),
          ],
        ],
      ),
    );
  }
}

class _Job extends StatelessWidget {
  const _Job(this.job);

  final Experience job;

  @override
  Widget build(BuildContext context) {
    final app = job.app;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(job.company, style: AppText.itemTitle),
        Text(job.role, style: AppText.small),
        const SizedBox(height: 12),
        Text(job.summary, style: AppText.body),
        const SizedBox(height: 8),
        Text(job.tech, style: AppText.code),
        if (app != null) ...[
          const SizedBox(height: 20),
          _AppLine(app),
          if (app.screenshots.isNotEmpty) ...[
            const SizedBox(height: 16),
            ScreenshotRow(images: app.screenshots, aspect: 480 / 853),
          ],
        ],
      ],
    );
  }
}

class _AppLine extends StatelessWidget {
  const _AppLine(this.app);

  final LiveApp app;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.line),
          ),
          child: Image.asset(app.iconAsset, cacheWidth: 80),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Wrap(
            spacing: 16,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (app.appStoreUrl case final url?)
                TextLink('App Store', url: url, style: AppText.small),
              if (app.playStoreUrl case final url?)
                TextLink('Google Play', url: url, style: AppText.small),
              if (app.note case final note?) Text(note, style: AppText.small),
            ],
          ),
        ),
      ],
    );
  }
}
