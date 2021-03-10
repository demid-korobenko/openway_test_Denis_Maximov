import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_code/cubit/password_cubit.dart';
import 'package:password_code/cubit/password_event.dart';
import 'package:password_code/cubit/password_state.dart';

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  FocusNode secondFocusNode = FocusNode();
  String codeUI = '';

  @override
  void initState() {
    super.initState();
  }

  var f1 = TextEditingController();

  resetCode() {
    FocusScope.of(context).requestFocus(secondFocusNode);
    BlocProvider.of<PasswordCubit>(context).add(PasswordResetEvent());
    f1.text = '';
  }

  partCodeWorker() {
    BlocProvider.of<PasswordCubit>(context)
        .add(PasswordDataEvent(data: f1.text));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<PasswordCubit, PasswordState>(
          cubit: PasswordCubit(),
          builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(
                      'Enter the code',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  BlocConsumer<PasswordCubit, PasswordState>(
                      builder: (context, datastate) {
                    if (datastate is PasswordInitialState) {
                      return Container(
                        height: 50,
                      );
                    }
                    if (datastate is PaswordDataState) {
                      print("--> data: " + datastate.passwordUi.toString());
                      codeUI = datastate.passwordUi;
                      return Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (codeUI != '')
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width * .33,
                                    child: ListView.builder(
                                      itemCount: codeUI.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text(codeUI[i]),
                                        );
                                      },
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      );
                    }
                  }, listener: (context, state) {
                    print(state);
                  }),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 0,
                        height: 0,
                        child: TextFormField(
                          focusNode: secondFocusNode,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          controller: f1,
                          onChanged: (val) => partCodeWorker(),
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: FlatButton(
                      color: Colors.black12,
                      child: Text('reset code'),
                      onPressed: () {
                        resetCode();
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
