import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/routes/app_router.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/data/services/navigation_service.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.softGray,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: width > 460
                ? Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 45,
                    spacing: 45,
                    children: _buttonsGroup(),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: _buttonsGroup()
                              .map((b) => Padding(
                                    padding: const EdgeInsets.only(bottom: 45),
                                    child: b,
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buttonsGroup() {
    return [
      CustomButton(
        size: CustomSize.h2,
        width: 380,
        icon: Icons.person_search_outlined,
        text: 'Gestión de paciente',
        onPressed: () async {
          NavigationService.navigateTo(AppRouter.patientManagementView);
        },
      ),
      CustomButton(
        size: CustomSize.h2,
        width: 380,
        icon: Icons.pie_chart,
        text: 'Consultar gráfico',
        onPressed: () async {
          NavigationService.navigateTo(AppRouter.staticsView);
        },
      ),
      CustomButton(
        size: CustomSize.h2,
        width: 380,
        icon: Icons.upload_file_outlined,
        text: 'Carga masiva',
        onPressed: () async {
          NavigationService.navigateTo(AppRouter.bulkUploadView);
        },
      ),
    ];
  }
}
