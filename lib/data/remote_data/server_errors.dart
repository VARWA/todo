enum ServerErrorType {
  wrongResponseError,
  authError,
  taskNotExists,
  otherError,
}

class ServerError implements Exception {
  final ServerErrorType type;

  ServerError(this.type);
}
