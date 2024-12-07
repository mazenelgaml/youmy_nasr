
class Brand {
  final int id;
  final String title, description;
  final int subCategoryId;

  Brand({
    required this.id,
    required this.subCategoryId,
    required this.title,
    required this.description,
  });
}


List<Brand> demoBrandsList = [
  Brand(
    id: 1,
    subCategoryId: 1,
    title: "Store License",
    description: "Store License etc....",
  ),
  Brand(
    id: 2,
    subCategoryId:1,
    title: "Tax License",
    description: "Tax License etc....",
  ),
  Brand(
    id: 3,
    subCategoryId: 1,
    title: "Other License",
    description: "Other License etc....",
  ),
];

