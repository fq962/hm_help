import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/bloc_files/logup_bloc.dart';

class Providerr extends InheritedWidget {
  final logupBloc = LogupBloc();

  Providerr({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LogupBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Providerr>()!.logupBloc;
  }
}
