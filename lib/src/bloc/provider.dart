import 'package:flutter/material.dart';

import 'package:formvalidation/src/bloc/login_bloc.dart';
export 'package:formvalidation/src/bloc/login_bloc.dart';
import 'package:formvalidation/src/bloc/products_bloc.dart';
export 'package:formvalidation/src/bloc/products_bloc.dart';


class Provider extends InheritedWidget {

  final loginBloc = LoginBloc();
  final _productsBloc = new ProductsBloc();


  static Provider _instance;

  factory Provider({Key key, Widget child}) {

    if (_instance == null) {
      _instance = Provider._internal(key: key, child: child);
    }

    return _instance;
  }

  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);



  /*Provider({Key key, Widget child})
    : super(key: key, child: child);
  */

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductsBloc productsBloc (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productsBloc;
  }
}