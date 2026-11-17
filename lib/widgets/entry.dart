import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'common.dart';
import 'screenshots.dart';

/// One numbered item in Work or Projects: text on the left, phones on the
/// right on wide screens, stacked on phones.
class NumberedEntry extends StatelessWidget {
  const NumberedEntry({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.tech,
    this.stats = const [],
    this.icon,
    this.links = const [],
    this.images = const [],
    this.aspect = 480 / 1066,
  });

  final int number;
  final String title;
  final String subtitle;
  final String body;
  final String tech;

  /// Short facts shown big, e.g. '150k+ users'.
  final List<String> stats;
  final String? icon;
  final List<Widget> links;
  final List<String> images;
  final double aspect;

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              number.toString().padLeft(2, '0'),
              style: AppText.code.copyWith(color: AppColors.accent),
            ),
            const SizedBox(width: 14),
            if (icon case final icon?) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.asset(icon, width: 36, height: 36, cacheWidth: 72),
              ),
              const SizedBox(width: 12),
            ],
            Flexible(
              child: Text(
                title,
                style: AppText.itemTitle.copyWith(fontSize: narrow ? 32 : 44),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(subtitle, style: AppText.small),
        if (stats.isNotEmpty) ...[
          const SizedBox(height: 20),
          Wrap(
            spacing: 28,
            runSpacing: 8,
            children: [
              for (final s in stats)
                Text(
                  s,
                  style: AppText.lead.copyWith(
                    fontSize: 22,
                    color: AppColors.accent,
                  ),
                ),
            ],
          ),
        ],
        const SizedBox(height: 18),
        Text(body, style: AppText.body),
        const SizedBox(height: 14),
        Text(tech, style: AppText.code),
        if (links.isNotEmpty) ...[const SizedBox(height: 18), LinkRow(links)],
      ],
    );

    final phones = images.isEmpty
        ? null
        : PhoneRow(
            images: images,
            aspect: aspect,
            phoneWidth: narrow ? 150 : 180,
          );

    return Padding(
      padding: EdgeInsets.only(bottom: narrow ? 64 : 96),
      child: isWide(context) && phones != null
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: text),
                const SizedBox(width: 56),
                Expanded(flex: 6, child: phones),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: text,
                ),
                if (phones != null) ...[const SizedBox(height: 32), phones],
              ],
            ),
    );
  }
}
