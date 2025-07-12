import 'package:flutter_time_duration_picker/flutter_time_duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';

class CustomModal {
  static Future<void> showModal({
    required BuildContext context,
    required String? title,
    required String text,
    double minWidth = 0,
    double minHeight = 0,
    bool showCancelButton = true,
    bool showAcceptButton = true,
    Future<void> Function()? onPressedCancel,
    Future<void> Function()? onPressedAccept,
  }) async {
    if (minWidth > 680) throw Exception('minWidth cannot be greater than 680');
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => Dialog(
        backgroundColor: AppColors.modalBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.black, width: 1),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxWidth: 680,
            minHeight: minHeight,
            minWidth: minWidth,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title != null)
                Center(
                    child: H1(
                  text: title,
                  textAlign: TextAlign.center,
                  color: AppColors.modalTitle,
                )),
              if (title != null) const SizedBox(height: 20),
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
                        Navigator.of(context.mounted ? context : context).pop();
                        if (onPressedCancel != null) await onPressedCancel();
                      },
                      child: _customButton(isAcceptButton: false),
                    ),
                  if (showAcceptButton)
                    InkWell(
                      onTap: () async {
                        Navigator.of(context.mounted ? context : context).pop();
                        if (onPressedAccept != null) await onPressedAccept();
                      },
                      child: _customButton(isAcceptButton: true),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static Future<DateTime?> determineDate({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    bool includeTime = false,
    // required Function(DateTime? resultDate) updateDate,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double dialogWidth = constraints.maxWidth * 0.85;
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.base,
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
                dialogBackgroundColor: Colors.white,
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.base,
                  ),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: dialogWidth,
                  ),
                  child: child!,
                ),
              ),
            );
          },
        );
      },
    );

    List<int>? transformedTime;
    if (includeTime) {
      final String? pickedTime = await determineTime(
        context: context,
        focusNode: FocusNode(),
      );
      transformedTime = _getTimeFromText(pickedTime);
    }
    int hour = (transformedTime?.isNotEmpty ?? false) ? transformedTime![0] : 0;
    int minute = (transformedTime?.length ?? 0) > 1 ? transformedTime![1] : 0;
    int second = (transformedTime?.length ?? 0) > 2 ? transformedTime![2] : 0;

    if (pickedDate != null) {
      DateTime finalDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        hour,
        minute,
        second,
      );
      return finalDate;
    }
    return null;
  }

  //! Hour version #2
  static Future<String?> determineTimeWithSeconds({
    required BuildContext context,
    required FocusNode focusNode,
    String maxHourAllowed = "",
  }) async {
    final now = DateTime.now();
    final advHourController =
        TimeColumnController(initialValue: now.hour, minValue: 0, maxValue: 23);
    final advMinuteController = TimeColumnController(
        initialValue: now.minute, minValue: 0, maxValue: 59);
    final advSecondController = TimeColumnController(
        initialValue: now.second, minValue: 0, maxValue: 59);

    final result = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Selecciona la duración',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 16),
              TimeDurationPicker(
                theme: const TimeDurationPickerTheme(
                  selectedTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.base,
                  ),
                  unselectedTextStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                  separatorTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.base,
                  ),
                  separatorColor: AppColors.base,
                ),
                columns: [
                  TimeColumnConfig.hours(
                      separator: 'h',
                      separatorWidth: 20,
                      controller: advHourController),
                  TimeColumnConfig.minutes(
                      separator: 'm',
                      separatorWidth: 20,
                      controller: advMinuteController),
                  TimeColumnConfig.seconds(
                      separator: 's',
                      separatorWidth: 20,
                      controller: advSecondController),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.base,
                ),
                onPressed: () {
                  final String time =
                      '${advHourController.valueNotifier.value.toString().padLeft(2, '0')}:'
                      '${advMinuteController.valueNotifier.value.toString().padLeft(2, '0')}:'
                      '${advSecondController.valueNotifier.value.toString().padLeft(2, '0')}';
                  Navigator.of(context).pop(time);
                },
                child: const Text(
                  'Confirmar',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );

    if (result != null) {
      focusNode.unfocus();
      return result;
    }

    return null;
  }

  static Future<String?> determineTime({
    required BuildContext context,
    required FocusNode focusNode,
    String maxHourAllowed = "",
  }) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double dialogWidth = constraints.maxWidth * 0.85;

            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.base,
                  onPrimary: AppColors.white,
                  onSurface: Colors.black,
                  secondary: AppColors.base,
                  onSecondary: AppColors.white,
                ),
                dialogBackgroundColor: Colors.white,
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.base,
                  ),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: dialogWidth,
                  ),
                  child: child!,
                ),
              ),
            );
          },
        );
      },
    );

    if (pickedTime != null) {
      final String finalHour = pickedTime.format(context);
      focusNode.unfocus();
      return finalHour;
    }
    return null;
  }

  static List<int> _getTimeFromText(String? time) {
    if (time?.isEmpty ?? true) return const [];

    final timeObtained = time!.split(":");
    final hour = int.parse(timeObtained.isNotEmpty ? timeObtained[0] : '0');
    final minute = int.parse(timeObtained.length > 1 ? timeObtained[1] : '0');
    final seconds = int.parse(timeObtained.length > 2 ? timeObtained[2] : '0');
    return [hour, minute, seconds];
  }

  static Widget _customButton({bool isAcceptButton = true}) {
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
