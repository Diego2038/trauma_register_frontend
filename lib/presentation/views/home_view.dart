import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 45,
              spacing: 45,
              children: [
                CustomButton(
                  size: CustomSize.h2,
                  width: 380,
                  icon: Icons.person_search_outlined,
                  text: 'Gestión de paciente',
                  onPressed: () async {
                    print("a");
                  },
                ),
                CustomButton(
                  size: CustomSize.h2,
                  width: 380,
                  icon: Icons.pie_chart,
                  text: 'Consultar gráfico',
                  onPressed: () async {
                    print("a");
                  },
                ),
                CustomButton(
                  size: CustomSize.h2,
                  width: 380,
                  icon: Icons.upload_file_outlined,
                  text: 'Carga masiva',
                  onPressed: () async {
                    print("a");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
