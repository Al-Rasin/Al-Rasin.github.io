import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common.dart';
import 'spotlight_card.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SpotlightCard(
      onTap: () => openUrl(project.url),
      padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(project.icon, size: 20, color: AppColors.text),
              ),
              const Spacer(),
              const Icon(
                Icons.north_east_rounded,
                size: 18,
                color: AppColors.subtle,
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(project.title, style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(project.description, style: textTheme.bodyMedium),
          const SizedBox(height: 18),
          Text(
            project.tags.join('  ·  '),
            style: const TextStyle(fontSize: 12.5, color: AppColors.subtle),
          ),
        ],
      ),
    );
  }
}
