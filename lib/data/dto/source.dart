class Source {
  final String name;

  const Source({
    this.name,
  });

  factory Source.fromMap(Map<String, Object> map) => Source(
        name: map['name'] ?? '',
      );
}
