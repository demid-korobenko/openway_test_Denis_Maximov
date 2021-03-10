import 'package:bloc/bloc.dart';
import 'package:password_code/cubit/password_event.dart';
import 'package:password_code/cubit/password_state.dart';

class PasswordCubit extends Bloc<PasswordEvent, PasswordState> {
  PasswordCubit() : super(PasswordInitialState());

  String code = '';
  String codeTest = '1111';

  void resetCode() {
    code = '';
  }

  void setCode(event) {
    code = event.data;
  }

  Stream<PasswordState> mapEventToState(PasswordEvent event) async* {
    if (event is PasswordDataEvent) {
      if (event.data.length > 4) {
        yield PasswordHelper(message: 'Maximum 4 characters. please press reset');
      } else {
        setCode(event);
        yield PaswordDataState(passwordUi: code);
        if (code.length == 4) {
          if (code == codeTest) {
            yield PasswordCorectState(passwordCorect: true);
          } else {
            yield PasswordCorectState(passwordCorect: false);
          }
        }
      }
    } else if (event is PasswordResetEvent) {
      resetCode();
      yield PaswordDataState(passwordUi: code);
    }
    yield PaswordDataState(passwordUi: code);
  }
}
