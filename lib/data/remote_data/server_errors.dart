class WrongResponseError extends ServerError {}

class AuthError extends ServerError {}

class TaskNotExistsError extends ServerError {}

class OtherError extends ServerError {}

class ServerError implements Exception {}
