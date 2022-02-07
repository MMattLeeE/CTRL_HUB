import 'dart:async';

class LoginBloc {
  final StreamController<bool> _isLoadingConroller = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingConroller.stream;

  void dispose() {
    _isLoadingConroller.close();
  }

  void setIsLoading(bool isLoading) => _isLoadingConroller.add(isLoading);
}
