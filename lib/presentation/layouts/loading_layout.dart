import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';

class LoadingLayout extends StatelessWidget {
  const LoadingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  color: AppColors.base,
                  strokeWidth: 6,
                ),
              ),
              SizedBox(height: 20),
              H5(
                text: "Cargando...\nPor favor espere.",
                color: AppColors.base,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
