import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/core/routes/app_router.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/data/services/navigation_service.dart';
import 'package:trauma_register_frontend/presentation/layouts/home_layout.dart';
import 'package:trauma_register_frontend/presentation/layouts/loading_layout.dart';
import 'package:trauma_register_frontend/presentation/layouts/login_layout.dart';
import 'package:trauma_register_frontend/presentation/providers/auth_provider.dart';
import 'package:trauma_register_frontend/presentation/providers/expandable_title_provider.dart';
import 'package:trauma_register_frontend/presentation/providers/stats_data_provider.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_stats_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  AppRouter.setupRouter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TraumaDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExpandableTitleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StatsDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TraumaStatsProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final authenticated = authProvider.authStatus;
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.base,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // Material Design widgets
        GlobalWidgetsLocalizations.delegate,  // General widgets to Flutter
        GlobalCupertinoLocalizations.delegate, // iOS (Cupertino)
      ],
      supportedLocales: const [Locale('es', 'CO')],
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: AppRouter.router.generator,
      debugShowCheckedModeBanner: false,
      // initialRoute: AppRouter.login,
      initialRoute: '/',
      builder: (BuildContext context, Widget? child) {
        if (authenticated == AuthStatus.none) {
          return const LoadingLayout();
        }
        if (authenticated == AuthStatus.notAuthenticated) {
          return LoginLayout(child: child!);
        }
        return HomeLayout(child: child!);
      },
    );
  }
}
