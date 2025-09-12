import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/helpers/interpolate.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_stats_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_pie_chart.dart';
import 'package:trauma_register_frontend/presentation/widgets/date_range_picker_buttons.dart';

class InsuredPatientsContentView extends StatefulWidget {
  const InsuredPatientsContentView({
    super.key,
  });

  @override
  State<InsuredPatientsContentView> createState() =>
      _InsuredPatientsContentViewState();
}

class _InsuredPatientsContentViewState
    extends State<InsuredPatientsContentView> {
  DateTime? insuredPatientsStartDate;
  DateTime? insuredPatientsEndDate;
  late TraumaStatsProvider _traumaStatsProvider;

  @override
  void initState() {
    super.initState();
    _traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: false);
    _traumaStatsProvider.addListener(clearInsuredPatientsDates);
  }

  @override
  void dispose() {
    _traumaStatsProvider.removeListener(clearInsuredPatientsDates);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: true);
    return FutureBuilder(
      future: traumaStatsProvider.getInsuredPatients(
        startDate:
            insuredPatientsStartDate ?? traumaStatsProvider.globalStartDate,
        endDate: insuredPatientsEndDate ?? traumaStatsProvider.globalEndDate,
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
        final double width = MediaQuery.of(context).size.width;
        final bool isMobileView = width < 800;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomPieChart(
                    chartWidth: Interpolate.interpolate(
                      xMin: isMobileView ? 400 : 800,
                      xMax: isMobileView ? 600 : 1000,
                      yMin: 200,
                      yMax: 400,
                      x: width,
                    ),
                    chartHeight: 400,
                    data: genderData,
                    allowBadge: true,
                  ),
                ],
              ),
            ),
            DateRangePickerButtons(
              startDate: insuredPatientsStartDate ??
                  traumaStatsProvider.globalStartDate,
              endDate:
                  insuredPatientsEndDate ?? traumaStatsProvider.globalEndDate,
              updateStartDate: updateInsuredPatientsStartDate,
              updateEndDate: updateInsuredPatientsEndDate,
              clearDates: clearInsuredPatientsDates,
            ),
          ],
        );
      },
    );
  }

  void updateInsuredPatientsStartDate(DateTime? date) {
    insuredPatientsStartDate = date;
    setState(() => {});
  }

  void updateInsuredPatientsEndDate(DateTime? date) {
    insuredPatientsEndDate = date;
    setState(() => {});
  }

  void clearInsuredPatientsDates() {
    insuredPatientsStartDate = null;
    insuredPatientsEndDate = null;
    setState(() => {});
  }
}
