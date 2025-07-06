import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/data/models/custom/time_of_day.dart';

class TransformData {
  static V? getTransformedValue<V>(String? value) {
    if (V == String) {
      return _parseString(value) as V?;
    } else if (V == int) {
      return _parseInt(value) as V?;
    } else if (V == double) {
      return _parseDouble(value) as V?;
    } else if (V == bool) {
      return _parseBool(value) as V?;
    } else if (V == DateTime) {
      return _parseDate(value) as V?;
    } else if (V == TimeOfDay) {
      return _parseTimeOfDay(value) as V?;
    }else {
      return null;
    }
  }

  static String? _parseString(String? value) {
    if (value?.isEmpty ?? true) return null;
    return value;
  }

  static int? _parseInt(String? value) {
    try {
      if (value?.isEmpty ?? true) return null;
      return int.tryParse(value!);
    } catch (_) {
      return null;
    }
  }

  static double? _parseDouble(String? value) {
    try {
      if (value?.isEmpty ?? true) return null;
      return double.tryParse(value!);
    } catch (_) {
      return null;
    }
  }

  static bool? _parseBool(String? value) {
    if (value?.isEmpty ?? true) return null;
    if (value!.toLowerCase() == "sí" || value.toLowerCase() == "si") {
      return true;
    } else if (value.toLowerCase() == "no") {
      return false;
    }
    return null;
  }

  static DateTime? _parseDate(String? date) {
    try {
      if (date?.isEmpty ?? true) return null;
      return DateFormat('dd/MM/yyyy').parse(date!);
    } catch (_) {
      return null;
    }
  }
  
  static TimeOfDay? _parseTimeOfDay(String? value) {
    try {
      if (value?.isEmpty ?? true) return null;
      return TimeOfDay.fromString(value!);
    } catch (_) {
      return null;
    }
  }
}
