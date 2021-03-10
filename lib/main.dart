import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_code/cubit/password_cubit.dart';
import 'package:password_code/cubit/password_state.dart';
import 'package:password_code/password_page.dart';

import 'observer.dart';

void main() {
  Bloc.observer = Observer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (_) => PasswordCubit(),
          child: BlocListener<PasswordCubit, PasswordState>(
            listener: (context, state) {
              if (state is PasswordCorectState) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(milliseconds: 1000),
                  content:
                      Container(height: 2, child: LinearProgressIndicator()),
                ));
                Future.delayed(Duration(seconds: 1), () {
                  Scaffold.of(context).showSnackBar((state.passwordCorect)
                      ? SnackBar(
                          duration: Duration(milliseconds: 1000),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              ),
                              SizedBox(width: 10),
                              Text('code correct'),
                            ],
                          ),
                        )
                      : SnackBar(
                          duration: Duration(milliseconds: 500),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.do_disturb_alt_outlined,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Text('code not correct'),
                            ],
                          ),
                        ));
                });
              } else if (state is PasswordHelper) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(milliseconds: 1000),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.priority_high,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 10),
                      Text(state.message),
                    ],
                  ),
                ));
              }
            },
            child: PasswordPage(),
          ),
        ),
      ),
    );
  }
}
