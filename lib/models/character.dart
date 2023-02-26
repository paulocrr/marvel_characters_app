class Character {
  final int? id;
  final String? name;
  final String? description;
  final String? thumbnail;

  Character({
    this.id,
    this.name,
    this.description,
    this.thumbnail,
  });

  factory Character.fromJson(Map<String, dynamic> map) {
    return Character(
        id: map['id'] as int?,
        name: map['name'] as String?,
        description: map['description'] as String?,
        thumbnail:
            "${map['thumbnail']['path']}.${map['thumbnail']['extension']}");
  }
}
