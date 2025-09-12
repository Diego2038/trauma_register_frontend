import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/core/themes/app_colors.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_stats_provider.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_stats_container.dart';
import 'package:trauma_register_frontend/presentation/widgets/date_range_picker_buttons.dart';
import 'statics.dart';

class StaticsView extends StatelessWidget {
  const StaticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _CustomFilterBox(),
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                // alignment: WrapAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CustomStatsContainer(
                        minWidth: 555,
                        minHeight: 525,
                        title: "Distribución por género",
                        child: GendersContentView(),
                      ),
                      SizedBox(height: 20),
                      CustomStatsContainer(
                        minWidth: 555,
                        minHeight: 200,
                        title: "Cantidad de registros de pacientes",
                        child: AmountOfPatientsContentView(),
                      ),
                    ],
                  ),
                  CustomStatsContainer(
                    minWidth: 555,
                    minHeight: 740,
                    title: "Distribución por edad",
                    child: PatientsAgesContentView(),
                  ),
                  CustomStatsContainer(
                    minWidth: 555,
                    minHeight: 525,
                    title: "Distribución por aseguramiento",
                    child: InsuredPatientsContentView(),
                  ),
                  CustomStatsContainer(
                    minWidth: 555,
                    minHeight: 525,
                    title: "Distribución por tipo de admisión",
                    child: TypeOfPatientsAdmissionContentView(),
                  ),
                  CustomStatsContainer(
                    minWidth: 670,
                    minHeight: 425,
                    title: "Distribución por tipo de trauma",
                    child: PatientsWithRelationsContentView(),
                  ),
                  CustomStatsContainer(
                    minWidth: 625,
                    minHeight: 525,
                    title: "Cantidad de ingresos por año",
                    child: TraumaCountByDateContentView(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomFilterBox extends StatelessWidget {
  const _CustomFilterBox();

  @override
  Widget build(BuildContext context) {
    final traumaStatsProvider = Provider.of<TraumaStatsProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        // height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.base50,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomStatsContainer(
                title: "Filtro de fecha global",
                minHeight: 100,
                minWidth: width > 420 ? 400 : width - 20,
                maxWidth: width > 420 ? 400 : width - 20,
                // internColor: AppColors.base200,
                child: DateRangePickerButtons(
                  startDate: traumaStatsProvider.globalStartDate,
                  endDate: traumaStatsProvider.globalEndDate,
                  updateStartDate: traumaStatsProvider.updateGlobalStartDate,
                  updateEndDate: traumaStatsProvider.updateGlobalEndDate,
                  clearDates: traumaStatsProvider.clearGlobalDates,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
