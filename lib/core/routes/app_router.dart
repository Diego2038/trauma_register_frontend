import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/presentation/providers/auth_provider.dart';
import 'package:trauma_register_frontend/presentation/views/bulk_upload_view.dart';
import 'package:trauma_register_frontend/presentation/views/home_view.dart';
import 'package:trauma_register_frontend/presentation/views/login_view.dart';
import 'package:trauma_register_frontend/presentation/views/patient_management_view.dart';
import 'package:trauma_register_frontend/presentation/views/statics_view.dart';

class AppRouter {
  static final FluroRouter router = FluroRouter();

  static const login = '/';
  static const home = '/home';
  static const bulkUploadView = '/home/bulk-upload-view';
  static const patientManagementView = '/home/patient-management-view';
  static const staticsView = '/home/statics-view';

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

  static Handler bulkUploadViewHandler =
      Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BulkUploadView();
    } else {
      return const LoginView();
    }
  });

  static Handler patientManagementViewHandler =
      Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PatientManagementView();
    } else {
      return const LoginView();
    }
  });

  static Handler staticsViewHandler = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const StaticsView();
    } else {
      return const LoginView();
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
      bulkUploadView,
      handler: bulkUploadViewHandler,
      transitionType: TransitionType.none,
    );

    router.define(
      patientManagementView,
      handler: patientManagementViewHandler,
      transitionType: TransitionType.none,
    );

    router.define(
      staticsView,
      handler: staticsViewHandler,
      transitionType: TransitionType.none,
    );
  }
}
