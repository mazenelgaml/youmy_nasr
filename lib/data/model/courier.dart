class Courier {
  final int? id;
  final bool isActive;
  final String? name, mobile;

  Courier(
      {required this.id,
      this.isActive = true,
      required this.name,
      required this.mobile});
}

// Our demo Couriers



const String mobile = "Giza -Faisal";
