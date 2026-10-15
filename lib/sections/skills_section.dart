import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentWidth(
      child: Padding(
        padding: EdgeInsets.only(top: 20, bottom: isNarrow(context) ? 72 : 110),
        child: Column(
          children: [
            const SectionHeading(
              eyebrow: 'Stack',
              title: 'Tools I work with',
              center: true,
            ),
            const SizedBox(height: 40),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final s in PortfolioData.skills)
                  Pill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      child: Text(
                        s,
                        style: const TextStyle(
                          fontSize: 14.5,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
