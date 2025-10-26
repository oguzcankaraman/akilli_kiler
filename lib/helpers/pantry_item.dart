class PantryItem {
  final int? id;
  final String name;
  final DateTime expiryDate;

  PantryItem({
    this.id,
    required this.name,
    required this.expiryDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'expiry_date': expiryDate.toIso8601String(),
    };
  }

  factory PantryItem.fromMap(Map<String, dynamic> map) {
    return PantryItem(
      id: map['id'] as int?,
      name: map['name'] as String,
      expiryDate: DateTime.parse(map['expiry_date'] as String),
    );
  }
}
