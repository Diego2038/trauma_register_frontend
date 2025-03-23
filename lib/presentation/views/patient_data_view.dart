import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trauma_register_frontend/data/models/trauma_data/trauma_data.dart';
import 'package:trauma_register_frontend/presentation/providers/trauma_data_provider.dart';


class PatientDataView extends StatefulWidget {
  const PatientDataView({super.key});

  @override
  State<PatientDataView> createState() => _PatientDataViewState();
}

class _PatientDataViewState extends State<PatientDataView> {
  final TextEditingController _idController = TextEditingController();
  PatientData? _patientData;
  bool _isLoading = false;
  String? _errorMessage;
  bool _noData = false;

  void _searchPatient() async {
    setState(() => _noData = false);
    final idText = _idController.text.trim();
    if (idText.isEmpty) return;

    final id = int.tryParse(idText);
    if (id == null) {
      setState(() => _errorMessage = "ID inválido");
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _patientData = null;
    });

    try {
      final traumaDataProvider = context.read<TraumaDataProvider>();
      final patient = await traumaDataProvider.getPatientDataById(id.toString());
      setState(() => _patientData = patient);
      if (_patientData == null) _noData = true;
    } catch (e) {
      setState(() => _errorMessage = "Paciente no encontrado");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buscar Paciente")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: "ID del Paciente",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchPatient,
                ),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _searchPatient(),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            if (_patientData != null) 
              _buildPatientCard(_patientData!),
            if (_noData) Text(
                  "El usuario con el ID ${_idController.text.trim()} no existe",
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                )
          ],
        ),
      ),
    );
  }

  Widget _buildPatientCard(PatientData patient) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow("ID", patient.traumaRegisterRecordId?.toString() ?? "N/A"),
            _infoRow("Dirección", "${patient.direccionLinea1 ?? ''}, ${patient.direccionLinea2 ?? ''}"),
            _infoRow("Ciudad", patient.ciudad),
            _infoRow("Canton/Municipio", patient.cantonMunicipio),
            _infoRow("Provincia/Estado", patient.provinciaEstado),
            _infoRow("Código Postal", patient.codigoPostal),
            _infoRow("País", patient.pais),
            _infoRow("Edad", "${patient.edad ?? 'N/A'} ${patient.unidadDeEdad ?? ''}"),
            _infoRow("Género", patient.genero),
            _infoRow("Fecha de Nacimiento", patient.fechaDeNacimiento != null
              ? DateFormat.yMMMd().format(patient.fechaDeNacimiento!) 
              : "N/A"
            ),
            _infoRow("Ocupación", patient.ocupacion),
            _infoRow("Estado Civil", patient.estadoCivil),
            _infoRow("Nacionalidad", patient.nacionalidad),
            _infoRow("Grupo Étnico", patient.grupoEtnico),
            _infoRow("Otro Grupo Étnico", patient.otroGrupoEtnico),
            _infoRow("Doc. de Identificación", patient.numDocDeIdentificacion),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value ?? "N/A")),
        ],
      ),
    );
  }
}
