import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_stats_provider.dart';
// Asegúrate de importar correctamente tu TraumaStatsProvider

class DateRangePickerButtons extends StatelessWidget {
  const DateRangePickerButtons({super.key});

  Future<void> _selectDate(BuildContext context, DateTime? initialDate,
      Function(DateTime?) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1900), // Fecha inicial para la selección
      lastDate: DateTime.now()
          .add(const Duration(days: 365)), // Un año en el futuro desde hoy
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Escucha los cambios en TraumaStatsProvider
    final traumaStatsProvider = Provider.of<TraumaStatsProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ElevatedButton.icon(
                    onPressed: () => _selectDate(
                      context,
                      traumaStatsProvider.startDate,
                      traumaStatsProvider.updateStartDate,
                    ),
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      traumaStatsProvider.startDate == null
                          ? 'Fecha Inicial'
                          : 'Inicial: ${traumaStatsProvider.startDate!.toLocal().toString().split(' ')[0]}',
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10,),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ElevatedButton.icon(
                    onPressed: () => _selectDate(
                      context,
                      traumaStatsProvider.endDate,
                      traumaStatsProvider.updateEndDate,
                    ),
                    icon: const Icon(Icons.calendar_month),
                    label: Text(
                      traumaStatsProvider.endDate == null
                          ? 'Fecha Final'
                          : 'Final: ${traumaStatsProvider.endDate!.toLocal().toString().split(' ')[0]}',
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10,),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              traumaStatsProvider.clearDates();
            },
            icon: const Icon(Icons.clear),
            label: const Text('Limpiar Fechas'),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.redAccent, // Un color distintivo para limpiar
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
