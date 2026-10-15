import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/spotlight_card.dart';

/// Only added to the page when [PortfolioData.blogPosts] is not empty.
class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);

    return ContentWidth(
      child: Padding(
        padding: EdgeInsets.only(bottom: narrow ? 72 : 100),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                eyebrow: 'Blog',
                title: 'Latest writing',
                subtitle: 'Notes and lessons from building Flutter apps.',
              ),
              SizedBox(height: narrow ? 32 : 48),
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
                      for (final post in PortfolioData.blogPosts)
                        SizedBox(width: cardWidth, child: _BlogCard(post)),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  const _BlogCard(this.post);

  final BlogPost post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final meta = [post.date, ?post.readTime].join('  ·  ');

    return SpotlightCard(
      onTap: () => openUrl(post.url),
      padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  meta,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.subtle,
                  ),
                ),
              ),
              const Icon(
                Icons.north_east_rounded,
                size: 18,
                color: AppColors.subtle,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(post.title, style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(post.summary, style: textTheme.bodyMedium),
          const SizedBox(height: 18),
          const Text(
            'Read post',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
