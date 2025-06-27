import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final double size;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.color = AppColors.base,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: size),
      splashRadius: 24,
      tooltip: "Añadir",
    );
  }
}