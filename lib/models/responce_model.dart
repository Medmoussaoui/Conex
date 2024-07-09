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

  ///
  /// to know if the response comes with data or not
  ///
  bool get hasData => body != null;

  /// Http Responce Status Code
  ///
  /// are standard response codes given
  /// by web servers on the Internet. The codes help identify the
  /// status of the request made by a client to a server.
  ///
  int statusCode = 0;

  /// HTTP response headers
  ///
  /// are key-value pairs that are sent by the
  /// server along with the HTTP response. These headers provide important
  /// metadata about the response and the server
  ///
  Map<String, String> headers = {};

  /// Http Responce Body
  ///
  /// The HTTP response body is the part of the HTTP response that
  /// contains the data requested by the client
  ///
  Data? body;

  ConexResponce.success({
    this.state = ResponceStates.success,
    required Data? bodyData,
  }) {
    body = bodyData;
  }

  /// Client Error Responses (4xx)
  ///
  /// (400)
  /// Bad Request: The server could not understand the request
  /// due to invalid syntax.
  ///
  /// (401)
  /// Unauthorized: The client must authenticate itself to get
  /// the requested response.
  ///
  /// (403)
  /// Forbidden: The client does not have access rights to the content.
  /// And more ...
  ///
  ConexResponce.respondError({
    this.state = ResponceStates.respondError,
    required this.statusCode,
  });

  /// Server Error Responses (5xx)
  ///
  /// (500)
  /// Internal Server Error: The server has encountered a situation
  /// it doesn't know how to handle.
  ///
  /// (501)
  /// Not Implemented: The request method is not supported by the server
  /// and cannot be handled.
  ///
  /// (502)
  /// Bad Gateway: The server, while acting as a gateway or proxy, received
  /// an invalid response from the upstream server.
  ///
  /// (503)
  /// Service Unavailable: The server is not ready to handle the request,
  /// often due to maintenance or overload.
  /// and more...
  ///
  ConexResponce.serverError({
    this.state = ResponceStates.serverError,
    required this.statusCode,
  });

  /// Internet Connectivity Issues
  ConexResponce.internetProblem({
    this.state = ResponceStates.internetProblem,
  });

  bool get isSuccess => state == ResponceStates.success;
  bool get isRespondError => state == ResponceStates.respondError;
  bool get isServerError => state == ResponceStates.serverError;
  bool get isInternetProblem => state == ResponceStates.internetProblem;
}
