enum ServerErrorType {
  wrongResponseError,
  authError,
  taskNotExists,
  otherError
}

class ServerError implements Exception {
  final ServerError type;

  ServerError(this.type);
}
