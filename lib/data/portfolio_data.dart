class Project {
  const Project({
    required this.title,
    required this.description,
    required this.tech,
    required this.url,
    this.subtitle = '',
    this.screenshots = const [],
    this.learning = false,
  });

  final String title;

  /// One short line under the title.
  final String subtitle;
  final String description;

  /// Comma-separated, shown in mono under the description.
  final String tech;
  final String url;

  /// Asset paths of phone screenshots.
  final List<String> screenshots;

  /// Older course/practice apps, listed one line each at the end.
  final bool learning;
}

/// A store app shipped while working at a company.
class LiveApp {
  const LiveApp({
    required this.title,
    required this.iconAsset,
    this.appStoreUrl,
    this.playStoreUrl,
    this.screenshots = const [],
  });

  final String title;
  final String iconAsset;
  final String? appStoreUrl;
  final String? playStoreUrl;

  /// Store listing images (480x853).
  final List<String> screenshots;
}

class BlogPost {
  const BlogPost({required this.title, required this.date, required this.url});

  final String title;

  /// Shown as written, e.g. 'Oct 2026'.
  final String date;

  /// Link to the full post (Medium, dev.to, Hashnode, LinkedIn…).
  final String url;
}

class Experience {
  const Experience({
    required this.company,
    required this.role,
    required this.summary,
    required this.tech,
    this.stats = const [],
    this.app,
  });

  final String company;
  final String role;
  final String summary;
  final String tech;

  /// Real, checkable numbers only.
  final List<String> stats;
  final LiveApp? app;
}

class PortfolioData {
  static const name = 'Al Rasin';
  static const role = 'Mobile App Developer';
  static const email = 'alrasin500@gmail.com';

  /// WhatsApp chat link (wa.me takes the number without "+").
  static const whatsapp = 'https://wa.me/8801752591363';
  static const github = 'https://github.com/Al-Rasin';
  static const linkedin = 'https://www.linkedin.com/in/al-rasin-64ab7822a/';
  static const photo = 'assets/images/avatar.jpg';

  /// Served from web/cv/, relative so it works locally and on GitHub Pages.
  static const cv = 'cv/Al-Rasin-CV.pdf';

  static const intro =
      "I'm a mobile app developer in Dhaka. For the past two and a half "
      "years I've been shipping Flutter apps to the Play Store and App "
      'Store, most of it on TubeOnAI, an AI summarizer with over 150,000 '
      'users. Lately I also write native Android in Kotlin.';

  static const now =
      'Right now I\'m building an Android parental-control app for a '
      'European client and finishing my CSE degree at Southeast University.';

  static const tools =
      'Day to day I work in Flutter and Dart with Riverpod, GoRouter and '
      'Hive. On native Android I use Kotlin and Jetpack Compose. The '
      'backend is usually Firebase: Firestore, Auth, Cloud Functions and '
      'FCM.';

  static const experience = [
    Experience(
      company: 'Pinova Technologies',
      role: 'Mobile app development consultant, remote',
      summary:
          'Building the child-side Android app of a parental-control '
          'product for families in the EU. Screen-time limits with a '
          'warning at 80%, web filtering, device pairing with link codes '
          'and alerts back to the parent. I also own the Firebase data '
          'model, security rules and Cloud Functions.',
      tech: 'Kotlin, Jetpack Compose, Firebase, Cloud Functions',
    ),
    Experience(
      company: 'TubeOnAI',
      role: 'Mobile app developer (Flutter), remote',
      summary:
          'Summaries of YouTube videos, podcasts and articles. I moved the '
          'app from GetX to Riverpod, cut start-up time by about 20% with '
          'Hive caching, set up GoRouter deep links that open from a cold '
          'start, and built the streaming audio player with background '
          'playback.',
      tech: 'Flutter, Riverpod, GoRouter, Hive, REST',
      stats: ['150k+ users', '4.4 on the App Store'],
      app: LiveApp(
        title: 'TubeOnAI',
        iconAsset: 'assets/images/apps/tubeonai-icon.jpg',
        appStoreUrl:
            'https://apps.apple.com/us/app/tubeonai-summarize-anything/id6451212292',
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.tubeonai.app',
        screenshots: [
          'assets/images/apps/tubeonai-1.jpg',
          'assets/images/apps/tubeonai-2.jpg',
          'assets/images/apps/tubeonai-3.jpg',
        ],
      ),
    ),
    Experience(
      company: 'HelloTask',
      role: 'Flutter developer intern, Dhaka',
      summary:
          'My first job. Worked on the app for booking home help: real-time '
          'search, location tracking, localization and a shorter sign-up '
          'flow.',
      tech: 'Flutter, Firebase, Google Maps',
      app: LiveApp(
        title: 'HelloTask',
        iconAsset: 'assets/images/apps/hellotask-icon.jpg',
        playStoreUrl:
            'https://play.google.com/store/apps/details?id=com.robotlogistics.callrobot',
        screenshots: [
          'assets/images/apps/hellotask-1.jpg',
          'assets/images/apps/hellotask-2.jpg',
          'assets/images/apps/hellotask-3.jpg',
        ],
      ),
    ),
  ];

  /// The Writing section only appears when this has at least one post.
  /// Add posts here, newest first.
  static const List<BlogPost> blogPosts = [];

  static const projects = [
    Project(
      title: 'Transcribr',
      subtitle: 'Speech to text that never leaves the phone',
      description:
          'Offline speech-to-text app running whisper.cpp on the device. '
          '99+ languages, with SRT, WebVTT, JSON and plain-text export.',
      tech: 'Flutter, whisper.cpp',
      url: 'https://github.com/Al-Rasin/transcribr-legal',
      screenshots: [
        'assets/images/projects/transcribr-home.jpg',
        'assets/images/projects/transcribr-start.jpg',
        'assets/images/projects/transcribr-recording.jpg',
        'assets/images/projects/transcribr-transcript.jpg',
      ],
    ),
    Project(
      title: 'TV UART Tool',
      subtitle: 'Fixing TVs from a phone',
      description:
          'Android app to repair TVs and Android boxes over UART via USB '
          'serial, Bluetooth, Wi-Fi/ESP32 and IR remote. Guided auto-fix '
          'flows and a Bangla/English UI.',
      tech: 'Flutter, USB serial, Bluetooth, ESP32',
      url: 'https://github.com/Al-Rasin/tvuarttool-releases',
      screenshots: [
        'assets/images/projects/tvuart-home.jpg',
        'assets/images/projects/tvuart-problem.jpg',
        'assets/images/projects/tvuart-practice.jpg',
      ],
    ),
    Project(
      title: 'Jimi',
      subtitle: 'A voice assistant with no cloud',
      description:
          'Offline voice assistant for a rooted Android phone. Wake word, '
          'speech to text and small local models, all on the phone.',
      tech: 'Kotlin, Android, llama.cpp',
      url: 'https://github.com/Al-Rasin/jimi',
      screenshots: [
        'assets/images/projects/jimi-chat.jpg',
        'assets/images/projects/jimi-settings.jpg',
        'assets/images/projects/jimi-wake-word.jpg',
      ],
    ),
    Project(
      title: 'Focus Guard',
      subtitle: 'Less scrolling, on Android and Mac',
      description:
          'Self-control tool for Android and macOS. Adds friction to Shorts '
          'and Reels and blocks adult content. Works on Android without root '
          'through an Accessibility service.',
      tech: 'Java, Android Accessibility, macOS daemon',
      url: 'https://github.com/Al-Rasin/focus-guard',
      screenshots: [
        'assets/images/projects/focusguard-welcome.jpg',
        'assets/images/projects/focusguard-home.jpg',
        'assets/images/projects/focusguard-apps.jpg',
        'assets/images/projects/focusguard-settings.jpg',
      ],
    ),
    Project(
      title: 'SEU Matrimony',
      learning: true,
      description:
          'Team-built matrimony app with profiles, match filters, chat '
          'and calls.',
      tech: 'Flutter, Firebase, GetX',
      url: 'https://github.com/Al-Rasin/seu-matrimony',
      screenshots: [
        'assets/images/projects/seu-login.jpg',
        'assets/images/projects/seu-home.jpg',
        'assets/images/projects/seu-matches.jpg',
        'assets/images/projects/seu-profile.jpg',
      ],
    ),
    Project(
      title: 'Chat App',
      learning: true,
      description:
          'Real-time chat app built with Flutter, using Firebase as the backend.',
      tech: 'Flutter, Firebase',
      url: 'https://github.com/Al-Rasin/chat-app-flutter',
      screenshots: [
        'assets/images/projects/chat-login.jpg',
        'assets/images/projects/chat-signup.jpg',
        'assets/images/projects/chat-messages.jpg',
      ],
    ),
    Project(
      title: 'Mission Flutter',
      learning: true,
      description:
          'Personal Flutter learning tracker with time logging, note-taking, '
          'progress tracking and filtering.',
      tech: 'Flutter, Dart',
      url: 'https://github.com/Al-Rasin/Mission-Flutter',
      screenshots: [
        'assets/images/projects/mission-roadmap.jpg',
        'assets/images/projects/mission-task.jpg',
        'assets/images/projects/mission-progress.jpg',
      ],
    ),
    Project(
      title: 'Gambit',
      learning: true,
      description:
          'Game app with a list of online gaming websites plus several '
          'offline games.',
      tech: 'Flutter, Dart',
      url: 'https://github.com/Al-Rasin/gambit',
      screenshots: [
        'assets/images/projects/gambit-home.jpg',
        'assets/images/projects/gambit-flappy.jpg',
        'assets/images/projects/gambit-runner.jpg',
        'assets/images/projects/gambit-sites.jpg',
      ],
    ),
  ];
}
