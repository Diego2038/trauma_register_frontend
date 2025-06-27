import 'package:intl/intl.dart';
import 'package:trauma_register_frontend/core/constants/null_value.dart';
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
      //! TODO: Transform String to bool later (it's hard to establish a null value in booleans)
      return _parseBool(value) as V?;
    } else if (V == DateTime) {
      DateTime result = _parseDate(value);
      return result as V?;
    } else if (V == TimeOfDay) {
      //! TODO: Transform String to bool later (it's hard to establish a null value in booleans)
      TimeOfDay result = _parseTimeOfDay(value);
      return result as V?;
    }else {
      return null;
    }
  }

  static String _parseString(String? value) {
    if (value == null) return NullValue.nullString;
    return value.isNotEmpty ? value : NullValue.nullString;
  }

  static int? _parseInt(String? value) {
    return value?.isNotEmpty ?? false
        ? int.tryParse(value!)
        : NullValue.nullInt;
  }

  static double? _parseDouble(String? value) {
    return value?.isNotEmpty ?? false
        ? double.tryParse(value!)
        : NullValue.nullDouble;
  }

  static bool _parseBool(String? value) {
    return false; // TODO: Implement later
  }

  static DateTime _parseDate(String? date) {
    try {
      if (date?.isEmpty ?? true) return NullValue.nullDateTime;
      return DateFormat('dd/MM/yyyy').parse(date!);
    } on FormatException catch (_) {
      return NullValue.nullDateTime;
    }
  }
  
  static TimeOfDay _parseTimeOfDay(String? value) {
    return TimeOfDay(hour: 1, minute: 3); // TODO: Implement later
  }
}
