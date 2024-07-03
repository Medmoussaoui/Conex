enum ResponceStates {
  none,
  success,
  respondError,
  serverError,
  internetProblem,
}

class ConexResponce<Data> {
  ResponceStates state;

  ConexResponce({
    this.state = ResponceStates.none,
    Data? bodyData,
  }) {
    body = bodyData;
  }

  ConexResponce.success({
    this.state = ResponceStates.success,
    required Data? bodyData,
  }) {
    body = bodyData;
  }

  ConexResponce.respondError({
    this.state = ResponceStates.respondError,
    required this.statusCode,
  });

  ConexResponce.serverError({
    this.state = ResponceStates.serverError,
    required this.statusCode,
  });

  ConexResponce.internetProblem({
    this.state = ResponceStates.internetProblem,
  });

  bool get isSuccess => state == ResponceStates.success;
  bool get isRespondError => state == ResponceStates.respondError;
  bool get isServerError => state == ResponceStates.serverError;
  bool get isInternetProblem => state == ResponceStates.internetProblem;

  bool get hasData => body != null;

  int statusCode = 0;
  Data? body;
  Map<String, String> headers = {};
}
