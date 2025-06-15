import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_stats_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/date_range_picker_buttons.dart';

class AmountOfPatientsContentView extends StatelessWidget {
  const AmountOfPatientsContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: true);
    return FutureBuilder(
      future: traumaStatsProvider.getAmountOfPatients(
        startDate: traumaStatsProvider.amountOfPatientsStartDate ?? traumaStatsProvider.globalStartDate,
        endDate: traumaStatsProvider.amountOfPatientsEndDate ?? traumaStatsProvider.globalEndDate,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return const HeaderText(text: "Error al cargar los datos");
        }
        final singleValueStats = snapshot.data!;
        return Column(
          children: [
            H1(
              text: singleValueStats.data.toString(),
              color: AppColors.base,
            ),
            DateRangePickerButtons(
              startDate: traumaStatsProvider.amountOfPatientsStartDate ?? traumaStatsProvider.globalStartDate,
              endDate: traumaStatsProvider.amountOfPatientsEndDate ?? traumaStatsProvider.globalEndDate,
              updateStartDate: traumaStatsProvider.updateAmountOfPatientsStartDate,
              updateEndDate: traumaStatsProvider.updateAmountOfPatientsEndDate,
              clearDates: traumaStatsProvider.clearAmountOfPatientsDates,
            ),
          ],
        );
      },
    );
  }
}
