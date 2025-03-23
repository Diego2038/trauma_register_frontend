import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trauma_register_frontend/presentation/providers/stats_data_provider.dart';

class SimpleStatsView extends StatefulWidget {
  const SimpleStatsView({super.key});

  @override
  State<SimpleStatsView> createState() => _SimpleStatsViewState();
}
//! TODO: Hay un problema en esta vista, hay que manejar bien los datos null desde el backend con respecto a las estadísticas

class _SimpleStatsViewState extends State<SimpleStatsView> {
  List<BarChartGroupData> _chartData = [];
  List<String> labelsFromData = [];
  String _chartTitle = "";

  void _loadGenderStats(StatsDataProvider provider) async {
    final data = await provider.getStatsPatientsGenders();
    if (data != null) {
      setState(() {
        _chartTitle = "Género de Pacientes";
        labelsFromData = [];
        _chartData = data.asMap().entries.map((entry) {
          labelsFromData.add(entry.value['genero']);
          return BarChartGroupData(
            x: entry.key,
            barRods: [BarChartRodData(toY: entry.value['total'].toDouble(), color: Colors.blue)],
          );
        }).toList();
      });
    }
  }

  void _loadAgeStats(StatsDataProvider provider) async {
    final data = await provider.getStatsPatientsAges();
    if (data != null) {
      setState(() {
        _chartTitle = "Edades de Pacientes";
        labelsFromData = [];
        _chartData = data.asMap().entries.map((entry) {
          labelsFromData.add(entry.value['edad'].toString());
          return BarChartGroupData(
            x: entry.value['edad']!,
            barRods: [BarChartRodData(toY: entry.value['total']!.toDouble(), color: Colors.green)],
          );
        }).toList();
      });
    }
  }

  void _loadRelationStats(StatsDataProvider provider) async {
    final data = await provider.getStatsPatientsWithRelations();
    if (data != null) {
      setState(() {
        _chartTitle = "Pacientes con Relaciones";
        _chartData = data.entries.map((entry) {
          return BarChartGroupData(
            x: data.keys.toList().indexOf(entry.key),
            barRods: [BarChartRodData(toY: entry.value.toDouble(), color: Colors.red)],
          );
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final statsProvider = Provider.of<StatsDataProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Estadísticas de Pacientes")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _loadGenderStats(statsProvider),
                  child: const Text("Género"),
                ),
                ElevatedButton(
                  onPressed: () => _loadAgeStats(statsProvider),
                  child: const Text("Edad"),
                ),
                ElevatedButton(
                  onPressed: () => _loadRelationStats(statsProvider),
                  child: const Text("Relaciones"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(_chartTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: _chartData.isEmpty
                  ? const Center(child: Text("Selecciona una categoría"))
                  : BarChart(
                      // BarChartData(
                      //   barGroups: _chartData,
                      //   borderData: FlBorderData(show: false),
                      //   titlesData: FlTitlesData(show: false),
                      // ),
                      
                      BarChartData(
                        barGroups: _chartData,
                        borderData: FlBorderData(show: false),
                        // titlesData: FlTitlesData(
                        //   leftTitles: const AxisTitles(
                        //     sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                        //   ),
                        //   bottomTitles: AxisTitles(
                        //     sideTitles: SideTitles(
                        //       showTitles: true,
                        //       getTitlesWidget: (double value, TitleMeta meta) {
                        //         // Mapear valores numéricos a etiquetas de categorías
                        //         // final labels = ['Masculino', 'Femenino']; // O cualquier otra lista que necesites
                        //         final labels = labelsFromData;
                        //         return SideTitleWidget(
                        //           axisSide: meta.axisSide,
                        //           child: Text(
                        //             labels[value.toInt()], // Convierte el índice en una etiqueta
                        //             style: const TextStyle(fontSize: 12),
                        //           ),
                        //         );
                        //       },
                        //       reservedSize: 40, // Espacio para los títulos
                        //     ),
                        //   ),
                        // ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                if (value.toInt() >= 0 && value.toInt() < labelsFromData.length) {
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text(
                                      labelsFromData[value.toInt()], // Accede con seguridad
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  );
                                }
                                return Container(); // No mostrar nada si el índice no existe
                              },
                              reservedSize: 40,
                            ),
                          ),
                        ),
                      ),

                    ),
            ),
          ],
        ),
      ),
    );
  }
}
