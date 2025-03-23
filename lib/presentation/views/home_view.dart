import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/routes/app_router.dart';
import 'package:trauma_register_frontend/data/services/navigation_service.dart';
import '../providers/auth_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              NavigationService.navigateTo(AppRouter.login);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Center(child: Text("Bienvenido al Home")),
          ElevatedButton.icon(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
            icon: const Icon(Icons.exit_to_app),
            label: const Text('Cerrar sesión'),
            style: ElevatedButton.styleFrom(
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Bordes redondeados
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          createCustomButton(text: 'Vista paciente', redirect: AppRouter.patientDataView),
          createCustomButton(text: 'Estadísticas', redirect: AppRouter.simpleStatsView),
        ],
      ),
    );
  }

  Widget createCustomButton({required String text, required String redirect}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton.icon(
              onPressed: () {
                NavigationService.navigateTo(redirect);
              },
              icon: const Icon(Icons.exit_to_app),
              label: Text(text),
              style: ElevatedButton.styleFrom(
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Bordes redondeados
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
    );
  }
}
