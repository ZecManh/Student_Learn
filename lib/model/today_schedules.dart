
class TodaySchedules {
  TodaySchedules({
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.teachMethod,
  });

  DateTime startTime;
  DateTime endTime;
  String subject;
  String? address;
  String teachMethod;
  String? photoUrl;
  String? phoneNumber;
  String? learnerName;
  @override
  String toString() {
    return 'TodaySchedules{startTime: $startTime, endTime: $endTime, subject: $subject, address: $address, teachMethod: $teachMethod, photoUrl: $photoUrl, phoneNumber: $phoneNumber}';
  }
}
