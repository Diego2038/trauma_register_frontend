import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_stats_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/date_range_picker_buttons.dart';

class AmountOfPatientsContentView extends StatefulWidget {
  const AmountOfPatientsContentView({
    super.key,
  });

  @override
  State<AmountOfPatientsContentView> createState() => _AmountOfPatientsContentViewState();
}

class _AmountOfPatientsContentViewState extends State<AmountOfPatientsContentView> {
  DateTime? amountOfPatientsStartDate;
  DateTime? amountOfPatientsEndDate;
  late TraumaStatsProvider _traumaStatsProvider;

  @override
  void initState() {
    super.initState();
    _traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: false);
    _traumaStatsProvider.addListener(clearAmountOfPatientsDates);
  }

  @override
  void dispose() {
    _traumaStatsProvider.removeListener(clearAmountOfPatientsDates);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: true);
    return FutureBuilder(
      future: traumaStatsProvider.getAmountOfPatients(
        startDate: amountOfPatientsStartDate ?? traumaStatsProvider.globalStartDate,
        endDate: amountOfPatientsEndDate ?? traumaStatsProvider.globalEndDate,
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
              startDate: amountOfPatientsStartDate ?? traumaStatsProvider.globalStartDate,
              endDate: amountOfPatientsEndDate ?? traumaStatsProvider.globalEndDate,
              updateStartDate: updateAmountOfPatientsStartDate,
              updateEndDate: updateAmountOfPatientsEndDate,
              clearDates: clearAmountOfPatientsDates,
            ),
          ],
        );
      },
    );
  }

  void updateAmountOfPatientsStartDate(DateTime? date) {
    amountOfPatientsStartDate = date;
    setState(() => {});
  }

  void updateAmountOfPatientsEndDate(DateTime? date) {
    amountOfPatientsEndDate = date;
    setState(() => {});
  }

  void clearAmountOfPatientsDates() {
    amountOfPatientsStartDate = null;
    amountOfPatientsEndDate = null;
    setState(() => {});
  }
}
