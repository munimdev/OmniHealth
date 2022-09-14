//appointment class
class Appointment {
  final String appointmentId;
  final String appointmentPatient;
  final String appointmentDoctor;
  final String appointmentTime;
  final String appointmentDate;
  final String appointmentStatus;

  Appointment(
      {required this.appointmentId,
      required this.appointmentPatient,
      required this.appointmentDoctor,
      required this.appointmentTime,
      required this.appointmentDate,
      required this.appointmentStatus});

  //copywith method
  Appointment copyWith({
    String? appointmentId,
    String? appointmentPatient,
    String? appointmentDoctor,
    String? appointmentTime,
    String? appointmentDate,
    String? appointmentStatus,
  }) {
    return Appointment(
      appointmentId: appointmentId ?? this.appointmentId,
      appointmentPatient: appointmentPatient ?? this.appointmentPatient,
      appointmentDoctor: appointmentDoctor ?? this.appointmentDoctor,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentStatus: appointmentStatus ?? this.appointmentStatus,
    );
  }
}
