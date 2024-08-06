class Reward {
  final int id;
  final String name;
  final String description;
  final int
      value; // Peut être utilisé pour des récompenses monétaires ou des points

  Reward({
    required this.id,
    required this.name,
    required this.description,
    required this.value,
  });
}
