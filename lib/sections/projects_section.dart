import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../widgets/common.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentWidth(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isNarrow(context) ? 72 : 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              eyebrow: 'Work',
              title: 'Selected projects',
              subtitle: 'Flutter apps I have designed and built.',
            ),
            SizedBox(height: isNarrow(context) ? 32 : 48),
            LayoutBuilder(
              builder: (context, constraints) {
                const gap = 16.0;
                final columns = constraints.maxWidth >= 900
                    ? 3
                    : constraints.maxWidth >= 600
                    ? 2
                    : 1;
                final cardWidth =
                    (constraints.maxWidth - gap * (columns - 1)) / columns;

                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (final p in PortfolioData.projects)
                      SizedBox(
                        width: cardWidth,
                        child: ProjectCard(project: p),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
