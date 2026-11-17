import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      title: 'Writing',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final post in PortfolioData.blogPosts)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Wrap(
                spacing: 14,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  TextLink(post.title, url: post.url),
                  Text(post.date, style: AppText.code),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
