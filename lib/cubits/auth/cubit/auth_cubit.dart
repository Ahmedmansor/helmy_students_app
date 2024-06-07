import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

// chang visability
  bool isPassword = true;
  void changeVisablity() {
    isPassword = !isPassword;
    emit(ChangeVisabilityState());
  }

  // login Screen validate form
  var keyLogin = GlobalKey<FormState>();

  void validateFormLogin({
    required String email,
    required String password,
  }) {
    if (keyLogin.currentState!.validate()) {
      emit(LoginValidState());
    } else {
      emit(LoginInValidState());
    }
  }

  //login
  String email = "admin@gmail.com";
  String password = "Aa123456@";
  void login({required String email, required String password}) {
    if (email == this.email && password == this.password) {
      emit(SucessLoginState());
    } else {
      emit(ErrorLoginState());
    }
  }
}
