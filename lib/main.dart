import 'package:flutter/material.dart';
import 'package:my_urban_care/provider/bucket_provider.dart';
import 'package:my_urban_care/provider/home_provider.dart';
import 'package:my_urban_care/provider/notification_provider.dart';
import 'package:my_urban_care/provider/otp_provider.dart';
import 'package:my_urban_care/provider/profile_provider.dart';
import 'package:my_urban_care/provider/subscription_provider.dart';
import 'package:my_urban_care/provider/wallet_provider.dart';
import 'package:provider/provider.dart';
import 'Screens/splash_screen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> NotificationProvider()),
      ChangeNotifierProvider(create: (_)=> ProfileProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider( create: (_) => BucketProvider()),
      ChangeNotifierProvider(create: (_) => WalletProvider()),
      ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
      ChangeNotifierProvider(create: (_) => OtpProvider()),

    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Urban Care',
      theme: ThemeData(
          useMaterial3: true),
      home:  SplashScreen(),
    ),
    );
  }
}