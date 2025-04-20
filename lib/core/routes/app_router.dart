import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/presentation/providers/auth_provider.dart';
import 'package:trauma_register_frontend/presentation/views/home_view.dart';
import 'package:trauma_register_frontend/presentation/views/login_view.dart';
import 'package:trauma_register_frontend/presentation/views/patient_data_view.dart';
import 'package:trauma_register_frontend/presentation/views/simple_stats_view.dart';

class AppRouter {
  static final FluroRouter router = FluroRouter();

  static const login = '/';
  static const home = '/home';
  static const patientDataView = '/patient-data-view';
  static const simpleStatsView = '/simple-stats-view';

  static Handler loginHandler = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const HomeView();
    } else {
      return const LoginView();
    }
  });

  static Handler homeHandler = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const HomeView();
    } else {
      return const LoginView();
    }
  });

  static Handler patientDataViewHandler =
      Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PatientDataView();
    } else {
      return const PatientDataView();
      // return const LoginView();
    }
  });

  static Handler simpleStatsViewHandler =
      Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const SimpleStatsView();
    } else {
      return const SimpleStatsView();
      // return const LoginView();
    }
  });

  static void setupRouter() {
    router.define(
      login,
      handler: loginHandler,
      transitionType: TransitionType.none,
    );

    router.define(
      home,
      handler: homeHandler,
      transitionType: TransitionType.none,
    );

    router.define(
      patientDataView,
      handler: patientDataViewHandler,
      transitionType: TransitionType.none,
    );

    router.define(
      simpleStatsView,
      handler: simpleStatsViewHandler,
      transitionType: TransitionType.none,
    );
  }
}
