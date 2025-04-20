import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/helpers/local_storage.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/user/user_model.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final userJson = LocalStorage.prefs.getString('user') ??
        '{"username":"No name","email":""}';
    final UserModel user = UserModel.fromJson(json.decode(userJson));
    return Container(
      height: 45,
      width: double.infinity,
      color: AppColors.base,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const Spacer(),
            HeaderText(
              text: "Usuario: ${user.username}",
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
