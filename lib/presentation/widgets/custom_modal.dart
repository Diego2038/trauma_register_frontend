import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';

class CustomModal {
  static Future<void> showModal({
    required BuildContext context,
    required String title,
    required String text,
    bool showCancelButton = true,
    bool showAcceptButton = true,
    Future<void> Function()? onPressedCancel,
    Future<void> Function()? onPressedAccept,
  }) async {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => Dialog(
        backgroundColor: AppColors.modalBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), 
          side:
              const BorderSide(color: AppColors.black, width: 1), 
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(
            maxWidth: 680,
          ),
          decoration: BoxDecoration(
            color: AppColors.modalBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.black, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25), 
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.25), 
                offset: const Offset(0, 0),
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: H1(
                text: title,
                textAlign: TextAlign.center,
                color: AppColors.modalTitle,
              )),
              const SizedBox(height: 20),
              Center(
                child: H2(
                  text: text,
                  color: AppColors.modalText,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (showCancelButton)
                    InkWell(
                      onTap: () async {
                        if (onPressedAccept != null) await onPressedAccept();
                        Navigator.of(context.mounted ? context : context).pop();
                      },
                      child: customButton(isAcceptButton: false),
                    ),
                  if (showAcceptButton)
                    InkWell(
                      onTap: () async {
                        if (onPressedAccept != null) await onPressedAccept();
                        Navigator.of(context.mounted ? context : context).pop();
                      },
                      child: customButton(isAcceptButton: true),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget customButton({bool isAcceptButton = true}) {
    return Container(
      width: 260,
      height: 60,
      decoration: BoxDecoration(
          color: isAcceptButton ? AppColors.modalAccept : AppColors.modalCancel,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25), 
              offset: const Offset(0, 4),
              blurRadius: 4,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.25), 
              offset: const Offset(0, 0),
              blurRadius: 1,
            ),
          ]),
      child: Center(
        child: H3(
          text: isAcceptButton ? 'Aceptar' : 'Cancelar',
          color: isAcceptButton ? AppColors.white : AppColors.black,
        ),
      ),
    );
  }
}
