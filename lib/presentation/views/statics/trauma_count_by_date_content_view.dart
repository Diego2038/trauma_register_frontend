import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/stats/time_serie.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_stats_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_time_series_line_chart.dart';
import 'package:trauma_register_frontend/presentation/widgets/date_range_picker_buttons.dart';

class TraumaCountByDateContentView extends StatefulWidget {
  const TraumaCountByDateContentView({
    super.key,
  });

  @override
  State<TraumaCountByDateContentView> createState() => _TraumaCountByDateContentViewState();
}

class _TraumaCountByDateContentViewState extends State<TraumaCountByDateContentView> {
  DateTime? traumaCountByDateStartDate;
  DateTime? traumaCountByDateEndDate;
  late TraumaStatsProvider _traumaStatsProvider;

  @override
  void initState() {
    super.initState();
    _traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: false);
    _traumaStatsProvider.addListener(clearTraumaCountByDateDates);
  }

  @override
  void dispose() {
    _traumaStatsProvider.removeListener(clearTraumaCountByDateDates);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: true);
    return FutureBuilder(
      future: traumaStatsProvider.getTraumaCountByDate(
        startDate: traumaCountByDateStartDate ?? traumaStatsProvider.globalStartDate,
        endDate: traumaCountByDateEndDate ?? traumaStatsProvider.globalEndDate,
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
        final List<DateDatum> timeSeries = categoricalStats.data;
        return Column(
          children: [
            CustomTimeSeriesLineChart(
              chartHeight: 400,
              chartWidth: 600,
              data: timeSeries,
            ),
            DateRangePickerButtons(
              startDate: traumaCountByDateStartDate ?? traumaStatsProvider.globalStartDate,
              endDate: traumaCountByDateEndDate ?? traumaStatsProvider.globalEndDate,
              updateStartDate: updateTraumaCountByDateStartDate,
              updateEndDate: updateTraumaCountByDateEndDate,
              clearDates: clearTraumaCountByDateDates,
            ),
          ],
        );
      },
    );
  }

  void updateTraumaCountByDateStartDate(DateTime? date) {
    traumaCountByDateStartDate = date;
    setState(() => {});
  }

  void updateTraumaCountByDateEndDate(DateTime? date) {
    traumaCountByDateEndDate = date;
    setState(() => {});
  }

  void clearTraumaCountByDateDates() {
    traumaCountByDateStartDate = null;
    traumaCountByDateEndDate = null;
    setState(() => {});
  }
}
