class Courier {
  final int id;
  final bool isActive;
  final String name, mobile;

  Courier(
      {required this.id,
      this.isActive = true,
      required this.name,
      required this.mobile});
}

// Our demo Couriers

List<Courier> demoCouriers = [
  Courier(
    id: 1,
    name: "Ahmed Sayed ",
    mobile: "011156879542",
  ),
  Courier(id: 2, name: "Tamer Anwar", mobile: "012587542123", isActive: false),
  Courier(
    id: 3,
    name: "Akram Mohamed",
    mobile: "010857445327",
  ),
  Courier(
    id: 3,
    name: "Akram Mohamed",
    mobile: "010857445327",
  ),
  Courier(
    id: 3,
    name: "Akram Mohamed",
    mobile: "010857445327",
  ),
  Courier(
      id: 4, name: "Ashraf Mohamed", mobile: "012365478952", isActive: false),







];

const String mobile = "Giza -Faisal";
