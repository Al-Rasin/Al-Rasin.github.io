import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _copied = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _copy() async {
    await Clipboard.setData(const ClipboardData(text: PortfolioData.email));
    setState(() => _copied = true);
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);
    return Section(
      index: PortfolioData.blogPosts.isEmpty ? '04' : '05',
      title: 'Contact',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Got an app that needs building?',
            style: AppText.lead.copyWith(fontSize: narrow ? 26 : 40),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              "I'm open to remote Flutter and Android work. Email is the best "
              'way to reach me, and I usually reply within a day.',
              style: AppText.muted,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 18,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: TextLink(
                  PortfolioData.email,
                  url: 'mailto:${PortfolioData.email}',
                  style: AppText.lead.copyWith(fontSize: narrow ? 22 : 32),
                ),
              ),
              TextLink(
                _copied ? 'Copied' : 'Copy',
                style: AppText.small,
                onTap: _copy,
              ),
            ],
          ),
          const SizedBox(height: 28),
          const LinkRow([
            TextLink('WhatsApp', url: PortfolioData.whatsapp),
            TextLink('LinkedIn', url: PortfolioData.linkedin),
            TextLink('GitHub', url: PortfolioData.github),
          ]),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 120),
      padding: const EdgeInsets.only(top: 24, bottom: 48),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: const Text(
        'Built with Flutter, set in Bricolage Grotesque. Last updated November 2026.',
        style: AppText.code,
      ),
    );
  }
}
