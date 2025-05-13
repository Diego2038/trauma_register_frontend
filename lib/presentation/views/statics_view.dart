import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/core/themes/app_text.dart';
import 'package:trauma_register_frontend/data/models/stats/categorical_stats.dart';
import 'package:trauma_register_frontend/data/models/stats/time_serie.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_stats_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_time_series_line_chart.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_vertical_bar_chart.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_pie_chart.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_stats_container.dart';

class StaticsView extends StatelessWidget {
  const StaticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final traumaStatsProvider =
        Provider.of<TraumaStatsProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: [
                  Column(
                    children: [
                      CustomStatsContainer(
                        minWidth: 420,
                        minHeight: 350,
                        title: "Distribución por género",
                        child: gendersContent(traumaStatsProvider),
                      ),
                      const SizedBox(height: 20),
                      CustomStatsContainer(
                        minWidth: 420,
                        minHeight: 144,
                        title: "Cantidad de registros de pacientes",
                        child: amountOfPatientsContent(traumaStatsProvider),
                      ),
                    ],
                  ),
                  CustomStatsContainer(
                    minWidth: 420,
                    minHeight: 350,
                    title: "Distribución por edad",
                    child: patientsAgesContent(traumaStatsProvider),
                  ),
                  CustomStatsContainer(
                    minWidth: 420,
                    minHeight: 350,
                    title: "Distribución por aseguramiento",
                    child: insuredPatientsContent(traumaStatsProvider),
                  ),
                  CustomStatsContainer(
                    minWidth: 500,
                    minHeight: 350,
                    title: "Distribución por tipo de admisión",
                    child: typeOfPatientsAdmissionContent(traumaStatsProvider),
                  ),
                  CustomStatsContainer(
                    minWidth: 30,
                    minHeight: 350,
                    title: "Distribución por tipo de trauma",
                    child: patientsWithRelationsContent(traumaStatsProvider),
                  ),
                  CustomStatsContainer(
                    minWidth: 30,
                    minHeight: 350,
                    title: "Cantidad de ingresos por año",
                    child: traumaCountByDateContent(traumaStatsProvider),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget amountOfPatientsContent(TraumaStatsProvider traumaStatsProvider) {
    return FutureBuilder(
      future: traumaStatsProvider.getAmountOfPatients(),
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
        return H1(
          text: singleValueStats.data.toString(),
          color: AppColors.base,
        );
      },
    );
  }

  Widget gendersContent(TraumaStatsProvider traumaStatsProvider) {
    return FutureBuilder<CategoricalStats?>(
      future: traumaStatsProvider.getGenders(),
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

        return CustomPieChart(
          chartWidth: 400,
          chartHeight: 400,
          allowBadge: true,
          data: genderData,
        );
      },
    );
  }

  Widget patientsAgesContent(TraumaStatsProvider traumaStatsProvider) {
    return FutureBuilder(
      future: traumaStatsProvider.getPatientsAges(),
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

        return CustomVerticalBarChart(
          chartWidth: 500,
          chartHeight: 500,
          data: genderData,
        );
      },
    );
  }

  Widget patientsWithRelationsContent(TraumaStatsProvider traumaStatsProvider) {
    return FutureBuilder(
      future: traumaStatsProvider.getPatientsWithRelations(),
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
        return CustomVerticalBarChart(
          chartWidth: 650,
          chartHeight: 300,
          data: genderData,
        );
      },
    );
  }

  Widget insuredPatientsContent(TraumaStatsProvider traumaStatsProvider) {
    return FutureBuilder(
      future: traumaStatsProvider.getInsuredPatients(),
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
        return CustomPieChart(
          chartWidth: 300,
          chartHeight: 300,
          data: genderData,
        );
      },
    );
  }

  Widget typeOfPatientsAdmissionContent(
      TraumaStatsProvider traumaStatsProvider) {
    return FutureBuilder(
      future: traumaStatsProvider.getTypeOfPatientsAdmission(),
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
        return CustomVerticalBarChart(
          chartWidth: 450,
          chartHeight: 300,
          data: genderData,
        );
      },
    );
  }

  Widget traumaCountByDateContent(TraumaStatsProvider traumaStatsProvider) {
    return FutureBuilder(
      future: traumaStatsProvider.getTraumaCountByDate(),
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
        return CustomTimeSeriesLineChart(
          chartHeight: 400,
          chartWidth: 600,
          data: timeSeries,
        );
      },
    );
  }
}
