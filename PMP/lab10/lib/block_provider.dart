import 'package:flutter/material.dart';
import 'product_bloc.dart';

// Провайдер BLoC для доступа к BLoC
class BlocProvider extends InheritedWidget {
  final ProductBloc bloc;
  final Widget child;

  BlocProvider({required this.bloc, required this.child}) : super(child: child);

  static ProductBloc of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<BlocProvider>())!.bloc;

  @override
  bool updateShouldNotify(BlocProvider oldWidget) => true;
}
