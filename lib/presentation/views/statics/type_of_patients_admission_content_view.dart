import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_stats_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_vertical_bar_chart.dart';
import 'package:trauma_register_frontend/presentation/widgets/date_range_picker_buttons.dart';

class TypeOfPatientsAdmissionContentView extends StatefulWidget {
  const TypeOfPatientsAdmissionContentView({
    super.key,
  });

  @override
  State<TypeOfPatientsAdmissionContentView> createState() => _TypeOfPatientsAdmissionContentViewState();
}

class _TypeOfPatientsAdmissionContentViewState extends State<TypeOfPatientsAdmissionContentView> {
  DateTime? typeOfPatientsAdmissionStartDate;
  DateTime? typeOfPatientsAdmissionEndDate;
  late TraumaStatsProvider _traumaStatsProvider;

  @override
  void initState() {
    super.initState();
    _traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: false);
    _traumaStatsProvider.addListener(clearTypeOfPatientsAdmissionDates);
  }

  @override
  void dispose() {
    _traumaStatsProvider.removeListener(clearTypeOfPatientsAdmissionDates);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: true);
    return FutureBuilder(
      future: traumaStatsProvider.getTypeOfPatientsAdmission(
        startDate: typeOfPatientsAdmissionStartDate ?? traumaStatsProvider.globalStartDate,
        endDate: typeOfPatientsAdmissionEndDate ?? traumaStatsProvider.globalEndDate,
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
        final categoricalStats = snapshot.data!;
        final List<Datum> genderData = categoricalStats.data;
        return Column(
          children: [
            CustomVerticalBarChart(
              chartWidth: 450,
              chartHeight: 300,
              data: genderData,
            ),
            DateRangePickerButtons(
              startDate: typeOfPatientsAdmissionStartDate ?? traumaStatsProvider.globalStartDate,
              endDate: typeOfPatientsAdmissionEndDate ?? traumaStatsProvider.globalEndDate,
              updateStartDate: updateTypeOfPatientsAdmissionStartDate,
              updateEndDate: updateTypeOfPatientsAdmissionEndDate,
              clearDates: clearTypeOfPatientsAdmissionDates,
            ),
          ],
        );
      },
    );
  }

  void updateTypeOfPatientsAdmissionStartDate(DateTime? date) {
    typeOfPatientsAdmissionStartDate = date;
    setState(() => {});
  }

  void updateTypeOfPatientsAdmissionEndDate(DateTime? date) {
    typeOfPatientsAdmissionEndDate = date;
    setState(() => {});
  }

  void clearTypeOfPatientsAdmissionDates() {
    typeOfPatientsAdmissionStartDate = null;
    typeOfPatientsAdmissionEndDate = null;
    setState(() => {});
  }
}
