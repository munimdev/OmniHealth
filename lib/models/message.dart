//message class
class Message {
  final String messageId;
  final String messagePatient;
  final String messageDoctor;
  final String messageTime;
  final String messageDate;
  final String messageContent;

  Message(
      {required this.messageId,
      required this.messagePatient,
      required this.messageDoctor,
      required this.messageTime,
      required this.messageDate,
      required this.messageContent});
}
