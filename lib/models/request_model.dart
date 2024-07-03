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
  RequestState.loading({this.state = RequestStates.loading});
  RequestState.noInternet({this.state = RequestStates.noInternet});
  RequestState.error({this.state = RequestStates.error});
  RequestState.complete({this.state = RequestStates.complete});
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

  void dispose() {
    _liseners.clear();
  }
}
