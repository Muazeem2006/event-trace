import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:event_trace/controllers/booking_notifier.dart';
import 'package:event_trace/controllers/category_notifier.dart';
import 'package:event_trace/controllers/event_notifier.dart';
import 'package:event_trace/controllers/faq_notifier.dart';
import 'package:event_trace/controllers/promotion_notifier.dart';
import 'package:event_trace/controllers/ticket_notifier.dart';
import 'package:event_trace/controllers/user_notifier.dart';
import 'package:event_trace/controllers/venue_notifier.dart';
import 'package:event_trace/theme/theme_provider.dart';
import 'package:event_trace/views/addons/bookmark_screen.dart';
import 'package:event_trace/views/addons/edit_profile_screen.dart';
import 'package:event_trace/views/addons/events/event_faqs.dart';
import 'package:event_trace/views/addons/events/event_images.dart';
import 'package:event_trace/views/addons/events/event_tickets.dart';
import 'package:event_trace/views/addons/events/promote_event.dart';
import 'package:event_trace/views/addons/help_screen.dart';
import 'package:event_trace/views/addons/notification_screen.dart';
import 'package:event_trace/views/addons/search_screen.dart';
import 'package:event_trace/views/addons/setting_screen.dart';
import 'package:event_trace/views/auth/password_reset_screen.dart';
import 'package:event_trace/views/auth/verification_screen.dart';
import 'package:event_trace/views/components/introduction_screen.dart';
import 'package:event_trace/views/components/onboarding_screen.dart';
import 'package:event_trace/views/components/splash_screen.dart';
import 'package:event_trace/views/navpages/create_event_screen.dart';
import 'package:event_trace/views/navpages/profile_screen.dart';
import 'package:event_trace/views/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => BookingNotifier()),
      ChangeNotifierProvider(create: (context) => CategoryNotifier()),
      ChangeNotifierProvider(create: (context) => EventNotifier()),
      ChangeNotifierProvider(create: (context) => FaqNotifier()),
      ChangeNotifierProvider(create: (context) => PromotionNotifier()),
      ChangeNotifierProvider(create: (context) => TicketNotifier()),
      ChangeNotifierProvider(create: (context) => UserNotifier()),
      ChangeNotifierProvider(create: (context) => VenueNotifier()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: AnimatedSplashScreen(
        splash: const SplashScreen(),
        nextScreen: const OnboardingScreen(),
        duration: 4000,
        curve: Curves.easeInOut,
      ),
      routes: {
        // '/login': (context) => const SigninScreen(),
        // '/register': (context) => const SignupScreen(),
        '/verify': (context) => const VerificationScreen(),
        '/reset': (context) => const PasswordResetScreen(),
        '/start': (context) => const StartScreen(),
        '/search': (context) => const SearchScreen(),
        '/notification': (context) => const NotificationScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/bookmark': (context) => const BookmarkScreen(),
        '/settings': (context) => const SettingScreen(),
        '/help': (context) => const HelpScreen(),
        '/intro': (context) => const IntroductionScreen(),
        '/create_event': (context) => const CreateEventScreen(),
        '/add_images': (context) => const EventImages(),
        '/add_ticket': (context) => const EventTickets(),
        '/add_faq': (context) => const EventFaqs(),
        '/event_promotion': (context) => const PromoteEvent(),
      },
    );
  }
}
