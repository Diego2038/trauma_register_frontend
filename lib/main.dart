import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/core/routes/app_router.dart';
import 'package:trauma_register_frontend/data/services/navigation_service.dart';
import 'package:trauma_register_frontend/presentation/providers/auth_provider.dart';
import 'package:trauma_register_frontend/presentation/providers/stats_data_provider.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';

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
          create: (_) => StatsDataProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: AppRouter.router.generator,
      debugShowCheckedModeBanner: false,
      // initialRoute: AppRouter.login,
      initialRoute: '/',
      builder: (_, child) {
        return child ?? Container(color: Colors.blueAccent,); // Evita que el widget sea null
      },
    );
  }
}
