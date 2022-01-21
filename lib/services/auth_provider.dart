import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_ctrl/services/auth.dart';

class AuthProvider extends InheritedWidget {
  AuthProvider({
    required this.child,
    required this.auth,
  }) : super(child: child);

  final Widget child;
  final AuthBase auth;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }

  // final auth = AuthProvider.of(context);
  static AuthBase of(BuildContext context) {
    AuthProvider provider =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>()!;
    return provider.auth;
  }
}
