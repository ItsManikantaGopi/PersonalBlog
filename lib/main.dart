import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'utils/theme.dart';
import 'pages/portfolio_page.dart';
import 'core/di/injection.dart';

void main() {
  // Remove the # from URLs on web
  usePathUrlStrategy();

  // Initialize dependency injection
  configureDependencies();

  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manikanta Gopi - Software Engineer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const PortfolioPage(),

      // SEO and web configuration
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(1.0), // Prevent text scaling issues
          ),
          child: child!,
        );
      },
    );
  }
}
