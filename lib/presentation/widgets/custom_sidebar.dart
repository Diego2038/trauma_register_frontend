// lib/presentation/widgets/shared/custom_sidebar.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/action_type.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/routes/app_router.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/data/services/navigation_service.dart';
import 'package:trauma_register_frontend/presentation/providers/auth_provider.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_button.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_modal.dart';

class CustomSidebar extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final bool contractWithTap;

  const CustomSidebar({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    this.contractWithTap = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? 340 : 72,
      color: AppColors.base,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  isExpanded ? MainAxisAlignment.end : MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.close : Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: onToggle,
                )
              ],
            ),
            const SizedBox(height: 40),
            SidebarItem(
              isExpanded: isExpanded,
              icon: Icons.home_outlined,
              text: "Inicio",
              onPressed: () {
                if (contractWithTap) onToggle();
                NavigationService.navigateAndRemoveUntil(AppRouter.home);
              },
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                SidebarItem(
                  isExpanded: isExpanded,
                  icon: Icons.person_search_outlined,
                  text: "Gestión de paciente",
                  onPressed: () {
                    final traumaDataProvider =
                        Provider.of<TraumaDataProvider>(context, listen: false);
                    traumaDataProvider.updateAction(ActionType.buscar);
                    if (contractWithTap) onToggle();
                    NavigationService.navigateAndRemoveUntil(
                        AppRouter.patientManagementView);
                  },
                ),
                const SizedBox(height: 10),
                SidebarItem(
                  isExpanded: isExpanded,
                  icon: Icons.pie_chart,
                  text: "Consultar gráficos",
                  onPressed: () {
                    if (contractWithTap) onToggle();
                    NavigationService.navigateAndRemoveUntil(
                        AppRouter.staticsView);
                  },
                ),
                const SizedBox(height: 10),
                SidebarItem(
                  isExpanded: isExpanded,
                  icon: Icons.upload_file_outlined,
                  text: "Carga masiva",
                  onPressed: () {
                    if (contractWithTap) onToggle();
                    NavigationService.navigateAndRemoveUntil(
                        AppRouter.bulkUploadView);
                  },
                ),
              ],
            ),
            const Spacer(),
            SidebarItem(
              isExpanded: isExpanded,
              icon: Icons.logout,
              text: "Cerrar sesión",
              onPressed: () {
                final context = NavigationService.navigatorKey.currentContext!;
                if (contractWithTap) onToggle();
                CustomModal.showModal(
                  context: context,
                  minHeight: 160,
                  title: null,
                  text: '¿Desea cerrar sesión?',
                  onPressedAccept: () async {
                    Provider.of<AuthProvider>(context, listen: false).logout();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final bool isExpanded;
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const SidebarItem({
    super.key,
    required this.isExpanded,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment:
              isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            CustomButton(
              size: CustomSize.h3,
              icon: icon,
              height: 40,
              width: isExpanded ? 292 : null,
              text: isExpanded ? text : null,
              showShadow: false,
              startWithHover: true,
              onPressed: () async => onPressed(),
            ),
          ],
        ),
      ),
    );
  }
}
