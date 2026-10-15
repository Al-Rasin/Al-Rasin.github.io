import 'package:flutter/material.dart';

class Project {
  const Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.url,
    required this.icon,
  });

  final String title;
  final String description;
  final List<String> tags;
  final String url;
  final IconData icon;
}

class LiveApp {
  const LiveApp({
    required this.title,
    required this.publisher,
    required this.description,
    required this.icon,
    this.appStoreUrl,
    this.playStoreUrl,
  });

  final String title;
  final String publisher;
  final String description;
  final IconData icon;
  final String? appStoreUrl;
  final String? playStoreUrl;
}

class BlogPost {
  const BlogPost({
    required this.title,
    required this.summary,
    required this.date,
    required this.url,
    this.readTime,
  });

  final String title;
  final String summary;

  /// Shown as written, e.g. 'Oct 2026'.
  final String date;

  /// Link to the full post (Medium, dev.to, Hashnode, LinkedIn…).
  final String url;

  /// e.g. '5 min read'.
  final String? readTime;
}

class PortfolioData {
  static const name = 'Al Rasin';
  static const role = 'Flutter Developer';
  static const location = 'Dhaka, Bangladesh';
  static const email = 'alrasin500@gmail.com';

  /// WhatsApp chat link (wa.me takes the number without "+").
  static const whatsapp = 'https://wa.me/8801752591363';
  static const github = 'https://github.com/Al-Rasin';
  static const linkedin = 'https://www.linkedin.com/in/al-rasin-64ab7822a/';
  static const facebook = 'https://www.facebook.com/al.rasin.1';
  static const photo = 'assets/images/avatar.jpg';

  static const intro =
      'Flutter developer in Dhaka. I turn ideas into smooth, '
      'cross-platform apps with Flutter, Dart and Firebase.';

  static const skills = ['Flutter', 'Dart', 'Firebase', 'Google Maps'];

  static const liveApps = [
    LiveApp(
      title: 'TubeOnAI',
      publisher: 'TubeOnAI LLC',
      description:
          'AI summarizer for YouTube videos, podcasts and articles. '
          'Get the key points in seconds.',
      icon: Icons.auto_awesome_rounded,
      appStoreUrl:
          'https://apps.apple.com/us/app/tubeonai-summarize-anything/id6451212292',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.tubeonai.app',
    ),
    LiveApp(
      title: 'HelloTask',
      publisher: 'HelloTask Pte. Ltd.',
      description:
          'Book trusted home help and maids in Dhaka. Place and track '
          'orders right from your phone.',
      icon: Icons.cleaning_services_rounded,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.robotlogistics.callrobot',
    ),
  ];

  /// The Blog section and nav link only appear when this has at least one
  /// post. Add posts here, newest first.
  static const List<BlogPost> blogPosts = [];

  static const projects = [
    Project(
      title: 'Chat App',
      description:
          'Real-time chat app built with Flutter, using Firebase as the backend.',
      tags: ['Flutter', 'Firebase'],
      url: 'https://github.com/Al-Rasin/chat-app-flutter',
      icon: Icons.forum_rounded,
    ),
    Project(
      title: 'Mission Flutter',
      description:
          'Personal Flutter learning tracker with time logging, note-taking, '
          'progress tracking and filtering.',
      tags: ['Flutter', 'Dart'],
      url: 'https://github.com/Al-Rasin/Mission-Flutter',
      icon: Icons.rocket_launch_rounded,
    ),
    Project(
      title: 'Favorite Places',
      description:
          'Save favorite places with a photo and their location on Google Maps.',
      tags: ['Flutter', 'Google Maps'],
      url: 'https://github.com/Al-Rasin/favorite-places',
      icon: Icons.place_rounded,
    ),
    Project(
      title: 'Gambit',
      description:
          'Game app with a list of online gaming websites plus several '
          'offline games.',
      tags: ['Flutter', 'Dart'],
      url: 'https://github.com/Al-Rasin/gambit',
      icon: Icons.sports_esports_rounded,
    ),
    Project(
      title: 'Expense Tracker',
      description:
          'Daily expense tracker, built in 8 planned phases with a real '
          'git workflow.',
      tags: ['Flutter'],
      url: 'https://github.com/Al-Rasin/expense_tracker',
      icon: Icons.account_balance_wallet_rounded,
    ),
    Project(
      title: 'Shopping List',
      description:
          'Shopping list with categories, titles and quantities for every item.',
      tags: ['Flutter'],
      url: 'https://github.com/Al-Rasin/shopping-list',
      icon: Icons.shopping_basket_rounded,
    ),
  ];
}
