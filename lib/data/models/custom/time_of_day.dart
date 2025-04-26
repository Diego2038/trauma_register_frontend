class TimeOfDay {
  final int hour;
  final int minute;
  final int second;

  TimeOfDay({required this.hour, required this.minute, this.second = 0})
      : assert(hour >= 0 && hour < 24),
        assert(minute >= 0 && minute < 60),
        assert(second >= 0 && second < 60);

  factory TimeOfDay.fromString(String timeString) {
    final parts = timeString.split(':');
    if (parts.length < 2 || parts.length > 3) {
      throw const FormatException(
          'Formato de hora incorrecto (debe ser HH:MM o HH:MM:SS)');
    }

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    final second = parts.length == 3 ? int.tryParse(parts[2]) ?? 0 : 0;

    if (hour == null ||
        minute == null ||
        hour < 0 ||
        hour > 23 ||
        minute < 0 ||
        minute > 59 ||
        second < 0 ||
        second > 59) {
      throw const FormatException(
          'Valores de hora, minuto o segundo inválidos');
    }

    return TimeOfDay(hour: hour, minute: minute, second: second);
  }

  @override
  String toString() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeOfDay &&
          runtimeType == other.runtimeType &&
          hour == other.hour &&
          minute == other.minute &&
          second == other.second;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode ^ second.hashCode;

  // Método para comparar dos TimeOfDay
  int compareTo(TimeOfDay other) {
    if (hour != other.hour) {
      return hour.compareTo(other.hour);
    }
    if (minute != other.minute) {
      return minute.compareTo(other.minute);
    }
    return second.compareTo(other.second);
  }
}
