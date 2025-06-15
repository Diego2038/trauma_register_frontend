import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_stats_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_vertical_bar_chart.dart';
import 'package:trauma_register_frontend/presentation/widgets/date_range_picker_buttons.dart';

class PatientsAgesContentView extends StatefulWidget {
  const PatientsAgesContentView({
    super.key,
  });

  @override
  State<PatientsAgesContentView> createState() => _PatientsAgesContentViewState();
}

class _PatientsAgesContentViewState extends State<PatientsAgesContentView> {
  DateTime? patientsAgesStartDate;
  DateTime? patientsAgesEndDate;
  late TraumaStatsProvider _traumaStatsProvider;

  @override
  void initState() {
    super.initState();
    _traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: false);
    _traumaStatsProvider.addListener(clearPatientsAgesDates);
  }

  @override
  void dispose() {
    _traumaStatsProvider.removeListener(clearPatientsAgesDates);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: true);
    return FutureBuilder(
      future: traumaStatsProvider.getPatientsAges(
        startDate: patientsAgesStartDate ?? traumaStatsProvider.globalStartDate,
        endDate: patientsAgesEndDate ?? traumaStatsProvider.globalEndDate,
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
              chartWidth: 500,
              chartHeight: 500,
              data: genderData,
            ),
            DateRangePickerButtons(
              startDate: patientsAgesStartDate ?? traumaStatsProvider.globalStartDate,
              endDate: patientsAgesEndDate ?? traumaStatsProvider.globalEndDate,
              updateStartDate: updatePatientsAgesStartDate,
              updateEndDate: updatePatientsAgesEndDate,
              clearDates: clearPatientsAgesDates,
            ),
          ],
        );
      },
    );
  }

  void updatePatientsAgesStartDate(DateTime? date) {
    patientsAgesStartDate = date;
    setState(() => {});
  }

  void updatePatientsAgesEndDate(DateTime? date) {
    patientsAgesEndDate = date;
    setState(() => {});
  }

  void clearPatientsAgesDates() {
    patientsAgesStartDate = null;
    patientsAgesEndDate = null;
    setState(() => {});
  }
}
