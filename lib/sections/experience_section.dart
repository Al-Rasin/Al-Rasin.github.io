import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../widgets/common.dart';
import '../widgets/entry.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      index: '01',
      title: 'Work',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (i, job) in PortfolioData.experience.indexed)
            NumberedEntry(
              number: i + 1,
              title: job.company,
              subtitle: job.role,
              body: job.summary,
              tech: job.tech,
              stats: job.stats,
              icon: job.app?.iconAsset,
              images: job.app?.screenshots ?? const [],
              aspect: 480 / 853,
              links: [
                if (job.app?.appStoreUrl case final url?)
                  TextLink('App Store', url: url),
                if (job.app?.playStoreUrl case final url?)
                  TextLink('Google Play', url: url),
              ],
            ),
        ],
      ),
    );
  }
}
