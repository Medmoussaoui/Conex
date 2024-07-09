typedef RequestStateLisener = Function(RequestStates state);

enum RequestStates {
  loading,
  noInternet,
  error,
  none,
  complete,
}

class RequestState {
  RequestStates state;

  RequestState({this.state = RequestStates.none});

  /// Request Life Cycle State
  ///
  /// on the request send the state will be [loading]
  RequestState.loading({this.state = RequestStates.loading});

  /// Request Life Cycle State
  ///
  /// on request faild with internet problem the state will be [noInternet]
  RequestState.noInternet({this.state = RequestStates.noInternet});

  /// Request Life Cycle State
  ///
  /// on request faild bad request or unkown problem the state will be [error]
  RequestState.error({this.state = RequestStates.error});

  /// Request Life Cycle State
  ///
  /// on request success the state will be [complete]
  RequestState.complete({this.state = RequestStates.complete});

  /// Liseners
  ///
  /// callback of liseners
  List<RequestStateLisener> _liseners = [];

  void loading() {
    state = RequestStates.loading;
    notifyLiseners();
  }

  void complete() {
    state = RequestStates.complete;
    notifyLiseners();
  }

  void error() {
    state = RequestStates.error;
    notifyLiseners();
  }

  void noInternet() {
    state = RequestStates.noInternet;
    notifyLiseners();
  }

  void notifyLiseners() {
    for (final callback in _liseners) {
      callback(state);
    }
  }

  void addLisener(RequestStateLisener callback) {
    _liseners.add((state) => callback(state));
  }

  /// dispose Methode
  ///
  /// clean up these listeners [_liseners] to avoid memory leaks
  void dispose() {
    _liseners.clear();
  }
}
