import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';

class HomeLayout extends StatelessWidget {
  final Widget child;

  const HomeLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.modalAccept,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: AppColors.white,
                  height: double.infinity,
                  child: const Text("#HUV"),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 0,
                    left: 50,
                    right: 50,
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
