class Properties<T> {
  final Map<String, T> entries = {};

  /// Returns true if the properties map IS empty
  bool get isEmpty => this.entries.isEmpty;

  /// Main properties constructor.
  ///
  /// Can receive a properties [map].
  Properties({Map<String, T>? map}) {
    this.entries.addAll(map ?? {});
  }

  /// Add a new [property] with a specific [name].
  void add({required String name, required T property}) {
    this.entries[name] = property;
  }

  /// Remove the property with the specific [name] and return the deleted property.
  ///
  /// Throws an Exception is any property is found with the [name].
  T remove(String name) {
    if (contains(name)) {
      return entries.remove(name)!;
    } else {
      throw 'No property found with "$name" name';
    }
  }

  /// Get the property with the specific [name].
  ///
  /// Throws an Exception is any property is found with the [name].
  T getByName(String name) {
    if (contains(name)) {
      return entries[name]!;
    } else {
      throw 'No property found with "$name" name';
    }
  }

  /// Returns true if the property with the specific [name] is contained.
  bool contains(String name) {
    return this.entries.containsKey(name);
  }

  /// Convert this to a valid json representation for the Notion API.
  Map<String, dynamic> toJson() {
    throw 'Not implemented';
  }
}
