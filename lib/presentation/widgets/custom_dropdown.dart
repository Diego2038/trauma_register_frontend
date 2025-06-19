import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/enums/custom_size.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_size_text.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';

class CustomDropdown extends StatelessWidget {
  final CustomSize size;
  final String title;
  final String hintText;
  final String? selectedValue; // El valor actualmente seleccionado para el dropdown
  final List<String> items; // La lista de opciones para el dropdown
  final double? width;
  final double? height;
  final void Function(String?)? onItemSelected; // Callback cuando se selecciona un item
  final IconData? leftIcon; // Icono a la izquierda
  final IconData? customDropdownIcon; // Icono para el dropdown (reemplaza la flecha por defecto)

  const CustomDropdown({
    super.key,
    required this.size,
    required this.title,
    required this.hintText,
    required this.items, // Ahora requerido
    this.selectedValue,
    this.width,
    this.height,
    this.onItemSelected, // Ahora un parámetro específico para el dropdown
    this.leftIcon,
    this.customDropdownIcon, // Nuevo parámetro para el icono del dropdown
  }) : assert(
          size == CustomSize.h2 ||
              size == CustomSize.h3 ||
              size == CustomSize.h5,
          'Invalid size value.',
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTitle(),
          // customHeightSpace(), // Descomenta si necesitas espacio vertical entre título y dropdown
          customDropdownField(), // Renombrado de customInput a customDropdownField
        ],
      ),
    );
  }

  Widget customTitle() {
    // Lógica para el título, se mantiene igual
    return size == CustomSize.h2
        ? H2(
            text: title,
            color: AppColors.grey200,
          )
        : size == CustomSize.h3
            ? H3(
                text: title,
                color: AppColors.grey200,
              )
            : H5(
                text: title,
                color: AppColors.grey200,
              );
  }

  Widget customHeightSpace() {
    // Lógica para el espacio, se mantiene igual
    return SizedBox(
        height: size == CustomSize.h2
            ? 10
            : size == CustomSize.h3
                ? 7
                : 5);
  }

  Widget customDropdownField() {
    final double customSpace = size == CustomSize.h2
        ? 10
        : size == CustomSize.h3
            ? 7
            : 5;
    final double dimensionSize = size == CustomSize.h2
        ? AppSizeText.h2
        : size == CustomSize.h3
            ? AppSizeText.h3
            : AppSizeText.h5;
    const iconConstrain = BoxConstraints(
      minWidth: 0,
      minHeight: 0,
    );

    return DropdownButtonFormField<String>(
      // El valor actualmente seleccionado
      value: selectedValue,
      
      // Texto que se muestra cuando no hay nada seleccionado
      hint: Text(
        hintText,
        style: TextStyle(
          fontSize: dimensionSize,
          color: AppColors.grey200,
          fontWeight: FontWeight.w300,
        ),
      ),
      
      // Callback cuando se selecciona un nuevo elemento
      onChanged: onItemSelected,
      
      // Estilo del texto de los elementos seleccionados
      style: TextStyle(
        fontSize: dimensionSize,
        color: AppColors.black,
        fontWeight: FontWeight.w300,
      ),
      
      // Icono del desplegable (flecha)
      icon: customDropdownIcon != null
          ? Icon(
              customDropdownIcon,
              color: AppColors.grey200,
              size: dimensionSize,
            )
          : const Icon(Icons.arrow_drop_down), // Icono por defecto si no se provee uno
      
      // Los elementos del menú desplegable
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      
      // Decoración del campo (similar a TextField)
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        prefixIcon: leftIcon != null
            ? Padding(
                padding: EdgeInsets.only(
                  left: 5,
                  right: customSpace,
                ),
                child: Icon(
                  leftIcon,
                  color: AppColors.grey200,
                  size: dimensionSize,
                ),
              )
            : null,
        prefixIconConstraints: iconConstrain,
        // Eliminamos suffixIcon y onPressedRightIcon ya que el DropdownButtonFormField maneja su propio icono de flecha
        // y no tiene un onPressed para un suffixIcon arbitrario.
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColors.grey200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColors.grey200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColors.base),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: dimensionSize * 0.3,
          horizontal: 10,
        ),
      ),
    );
  }
}