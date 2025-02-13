class VideoItem {
  final String id;
  DateTime? lastWatched;

  VideoItem({
    required this.id,
    this.lastWatched,
  });
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoItem) return false;
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
