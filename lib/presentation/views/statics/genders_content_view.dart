import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_stats_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_pie_chart.dart';
import 'package:trauma_register_frontend/presentation/widgets/date_range_picker_buttons.dart';

class GendersContentView extends StatelessWidget {
  const GendersContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: true);
    return FutureBuilder<CategoricalStats?>(
      future: traumaStatsProvider.getGenders(
        startDate: traumaStatsProvider.gendersStartDate ?? traumaStatsProvider.globalStartDate,
        endDate: traumaStatsProvider.gendersEndDate ?? traumaStatsProvider.globalEndDate,
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
          return const HeaderText(text: "Error al cargar los datos de género");
        }

        final categoricalStats = snapshot.data!;
        final List<Datum> genderData = categoricalStats.data;

        return Column(
          children: [
            CustomPieChart(
              chartWidth: 400,
              chartHeight: 400,
              allowBadge: true,
              data: genderData,
            ),
            DateRangePickerButtons(
              startDate: traumaStatsProvider.gendersStartDate ?? traumaStatsProvider.globalStartDate,
              endDate: traumaStatsProvider.gendersEndDate ?? traumaStatsProvider.globalEndDate,
              updateStartDate: traumaStatsProvider.updateGendersStartDate,
              updateEndDate: traumaStatsProvider.updateGendersEndDate,
              clearDates: traumaStatsProvider.clearGendersDates,
            ),
          ],
        );
      },
    );
  }
}
