class Comic {
  final String resourceUri;
  final String name;

  Comic({required this.resourceUri, required this.name});

  factory Comic.fromJson(Map<String, dynamic> map) {
    return Comic(
      resourceUri: map['resourceURI'],
      name: map['name'],
    );
  }
}
