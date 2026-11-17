import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            PortfolioData.photo,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
            cacheWidth: 128,
          ),
        ),
        const SizedBox(height: 24),
        const Text(PortfolioData.name, style: AppText.name),
        const SizedBox(height: 4),
        Text('Mobile app developer', style: AppText.muted),
        const SizedBox(height: 28),
        const Text(PortfolioData.intro, style: AppText.body),
        const SizedBox(height: 16),
        Text(PortfolioData.now, style: AppText.muted),
        const SizedBox(height: 28),
        LinkRow([
          TextLink('Email', url: 'mailto:${PortfolioData.email}'),
          const TextLink('GitHub', url: PortfolioData.github),
          const TextLink('LinkedIn', url: PortfolioData.linkedin),
          TextLink(
            'CV (PDF)',
            onTap: () => openUrl(Uri.base.resolve(PortfolioData.cv).toString()),
          ),
        ]),
      ],
    );
  }
}

class ToolsSection extends StatelessWidget {
  const ToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Section(
      title: 'Tools',
      child: Text(PortfolioData.tools, style: AppText.body),
    );
  }
}
