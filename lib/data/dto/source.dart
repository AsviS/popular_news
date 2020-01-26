class Source {
  final String id;
  final String name;

  Source({
    this.id,
    this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Source && runtimeType == other.runtimeType && id == other.id && name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  Map<String, Object> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  factory Source.fromMap(Map<String, Object> map) {
    return Source(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
