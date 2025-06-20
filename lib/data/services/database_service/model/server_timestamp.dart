/// Một lớp placeholder để cho DatabaseService biết rằng nó nên sử dụng FieldValue.serverTimestamp().
class ServerTimestamp {
  const ServerTimestamp();
}

/// Một lớp placeholder để cho DatabaseService biết rằng nó nên sử dụng FieldValue.increment().
class FieldIncrement {
  final num value;
  const FieldIncrement(this.value);
}
