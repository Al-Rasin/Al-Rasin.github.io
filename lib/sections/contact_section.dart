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
    return Section(
      title: 'Contact',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "I'm open to remote Flutter and Android work. Email is the best "
            'way to reach me, and I usually reply within a day.',
            style: AppText.body,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const TextLink(
                PortfolioData.email,
                url: 'mailto:${PortfolioData.email}',
              ),
              TextLink(
                _copied ? 'Copied' : 'copy',
                style: AppText.small,
                onTap: _copy,
              ),
            ],
          ),
          const SizedBox(height: 14),
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
    return const Padding(
      padding: EdgeInsets.only(top: 80, bottom: 48),
      child: Text(
        'Built with Flutter, set in Newsreader. Last updated November 2026.',
        style: AppText.code,
      ),
    );
  }
}
