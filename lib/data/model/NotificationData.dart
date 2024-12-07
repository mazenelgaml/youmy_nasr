class NotificationData {
  final int id;
  final bool isReaded;
  final String title, description;

  NotificationData(
      {required this.id,
      this.isReaded = true,
      required this.title,
      required this.description});
}

// Our demo NotificationDatas

List<NotificationData> demoNotificationDatas = [
  NotificationData(
      id: 1,
      title: "New NotificationData",
      description: "New NotificationData - Description",
      isReaded: false),
  NotificationData(
      id: 2,
      title: "Happy Eid",
      description: "Happy Eid - Description",
      isReaded: false),
  NotificationData(
      id: 3,
      title: "New Vouchers",
      description: "New Vouchers - Description",
      isReaded: true),
  NotificationData(
      id: 4,
      title: "Ne Order",
      description: "New Order policy",
      isReaded: false),
  NotificationData(
      id: 5,
      title: "Discount Area",
      description: "Discount Area - Description",
      isReaded: false),
  NotificationData(
      id: 6,
      title: "Arrival Discount",
      description: "Arrival Discount - Description",
      isReaded: false),
];

const String description = "Giza -Faisal";
