import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';

class LoginLayout extends StatelessWidget {
  final Widget child;

  const LoginLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: AppColors.base,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(width > 880) Expanded(
                child: Container(
                  color: AppColors.white,
                  height: double.infinity,
                  child: Image.asset(
                    'assets/images/huv_simple_logo.jpg',
                    fit: BoxFit.cover,
                  ),
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
