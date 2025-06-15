import 'package:flutter/material.dart';
// Asegúrate de importar correctamente tu TraumaStatsProvider

class DateRangePickerButtons extends StatelessWidget {

  final DateTime? startDate;
  final DateTime? endDate;
  final void Function(DateTime?) updateStartDate;
  final void Function(DateTime?) updateEndDate;
  final void Function () clearDates;

  const DateRangePickerButtons({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.updateStartDate,
    required this.updateEndDate,
    required this.clearDates,
  });

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

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        runSpacing: 10,
        alignment: WrapAlignment.spaceAround,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton.icon(
                onPressed: () => _selectDate(
                  context,
                  startDate,
                  updateStartDate,
                ),
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  startDate == null
                      ? 'Fecha Inicial'
                      : 'Inicial: ${startDate!.toLocal().toString().split(' ')[0]}',
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
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
                  endDate,
                  updateEndDate,
                ),
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  endDate == null
                      ? 'Fecha Final'
                      : 'Final: ${endDate!.toLocal().toString().split(' ')[0]}',
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  clearDates();
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
            ),
          ),
        ],
      ),
    );
  }
}
