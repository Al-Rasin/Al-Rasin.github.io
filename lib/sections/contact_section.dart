import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);

    return ContentWidth(
      child: Padding(
        padding: EdgeInsets.only(bottom: narrow ? 48 : 80),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: narrow ? 24 : 64,
            vertical: narrow ? 56 : 88,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
            gradient: RadialGradient(
              center: const Alignment(0, -1.4),
              radius: 1.4,
              colors: [
                AppColors.accent.withValues(alpha: .18),
                AppColors.surface,
              ],
            ),
          ),
          child: Column(
            children: [
              SectionHeading(
                eyebrow: 'Contact',
                title: "Let's build something\ntogether.",
                subtitle:
                    'Have an app idea or a role in mind? '
                    'Email me or message me on WhatsApp.',
                center: true,
              ),
              const SizedBox(height: 36),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  AppButton(
                    label: 'Email me',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () => openUrl('mailto:${PortfolioData.email}'),
                  ),
                  AppButton(
                    label: PortfolioData.email,
                    primary: false,
                    onPressed: () => openUrl('mailto:${PortfolioData.email}'),
                  ),
                  AppButton(
                    label: 'WhatsApp',
                    icon: Icons.chat_rounded,
                    primary: false,
                    onPressed: () => openUrl(PortfolioData.whatsapp),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const SocialLinks(alignment: WrapAlignment.center),
            ],
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: ContentWidth(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28),
          child: Flex(
            direction: isNarrow(context) ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8,
            children: [
              Text(
                '© ${DateTime.now().year} ${PortfolioData.name}',
                style: const TextStyle(fontSize: 13.5, color: AppColors.subtle),
              ),
              const Text(
                'Built with Flutter',
                style: TextStyle(fontSize: 13.5, color: AppColors.subtle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
