import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/routes/app_router.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_size_text.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/services/navigation_service.dart';
import 'package:trauma_register_frontend/presentation/providers/auth_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isError = false;

  Future<void> _login(BuildContext context) async {
    if (_isLoading) return;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    bool success = await authProvider.login(
      username: _emailController.text.trim(),
      password: _passwordController.text,
    );

    setState(() => _isLoading = false);
    print(success);
    if (!success) {
      setState(() => _isError = true);
      return;
    }
    NavigationService.navigateTo(AppRouter.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.base,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: H1(
                          text: "Inicio de sesión",
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 20,
                        child: H6(
                          text: "Bienvenido al portal de registro de traumas",
                          color: AppColors.grey200,
                        ),
                      ),
                      const SizedBox(height: 37),
                      const SizedBox(
                        width: double.infinity,
                        child: H4(
                          text: "Usuario",
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      customInput(
                        controller: _emailController,
                        hintText: "Ingrese su correo electrónico",
                      ),
                      const SizedBox(height: 37),
                      const SizedBox(
                        width: double.infinity,
                        child: H4(
                          text: "Contraseña",
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      customInput(
                        controller: _passwordController,
                        hintText: "Ingrese su contraseña",
                        obscureText: true,
                      ),
                      const SizedBox(height: 37),
                      Center(
                        child: Column(
                          children: [
                            CustomButton(
                              size: CustomSize.h4,
                              height: 34,
                              width: 305,
                              centerButtonContent: true,
                              text: "Ingresar",
                              onPressed: () async {
                                await _login(
                                    context.mounted ? context : context);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: SizedBox(
                                height: 25,
                                child: _isError
                                    ? const H6(
                                        text:
                                            "Usuario o contraseña no válidas, por favor intente nuevamente",
                                        color: AppColors.errorLogin,
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customInput({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    const fontSize = AppSizeText.h4;
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25), 
          offset: const Offset(4, 4),
          blurRadius: 4,
        ),
      ]),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: fontSize,
          color: AppColors.black,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: fontSize,
            color: AppColors.grey200,
            fontWeight: FontWeight.w300,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.black, width: 0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.black, width: 0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.black, width: 0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
        ),
      ),
    );
  }
}

