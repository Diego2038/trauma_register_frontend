import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_stats_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_vertical_bar_chart.dart';
import 'package:trauma_register_frontend/presentation/widgets/date_range_picker_buttons.dart';

class PatientsWithRelationsContentView extends StatefulWidget {
  const PatientsWithRelationsContentView({
    super.key,
  });

  @override
  State<PatientsWithRelationsContentView> createState() => _PatientsWithRelationsContentViewState();
}

class _PatientsWithRelationsContentViewState extends State<PatientsWithRelationsContentView> {
  DateTime? patientsWithRelationsStartDate;
  DateTime? patientsWithRelationsEndDate;
  late TraumaStatsProvider _traumaStatsProvider;

  @override
  void initState() {
    super.initState();
    _traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: false);
    _traumaStatsProvider.addListener(clearPatientsWithRelationsDates);
  }

  @override
  void dispose() {
    _traumaStatsProvider.removeListener(clearPatientsWithRelationsDates);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: true);
    return FutureBuilder(
      future: traumaStatsProvider.getPatientsWithRelations(
        startDate: patientsWithRelationsStartDate ?? traumaStatsProvider.globalStartDate,
        endDate: patientsWithRelationsEndDate ?? traumaStatsProvider.globalEndDate,
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomVerticalBarChart(
              chartWidth: 650,
              chartHeight: 300,
              data: genderData,
            ),
            DateRangePickerButtons(
              startDate: patientsWithRelationsStartDate ?? traumaStatsProvider.globalStartDate,
              endDate: patientsWithRelationsEndDate ?? traumaStatsProvider.globalEndDate,
              updateStartDate: updatePatientsWithRelationsStartDate,
              updateEndDate: updatePatientsWithRelationsEndDate,
              clearDates: clearPatientsWithRelationsDates,
            ),
          ],
        );
      },
    );
  }

  void updatePatientsWithRelationsStartDate(DateTime? date) {
    patientsWithRelationsStartDate = date;
    setState(() => {});
  }

  void updatePatientsWithRelationsEndDate(DateTime? date) {
    patientsWithRelationsEndDate = date;
    setState(() => {});
  }

  void clearPatientsWithRelationsDates() {
    patientsWithRelationsStartDate = null;
    patientsWithRelationsEndDate = null;
    setState(() => {});
  }
}
