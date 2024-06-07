import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helmy/repos/colors.dart';

import '../../../../../cubits/auth/cubit/auth_cubit.dart';
import '../../../core/utils/app_settings.dart';
import '../../../core/utils/navigation.dart';
import '../../dash_board/presentation/dash_board_view.dart';

// ignore: must_be_immutable
class LoginButton extends StatelessWidget {
  LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSettings.width,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SucessLoginState) {
            NavigationUtils.goToAndOff(context, const DashBoardView());
            Fluttertoast.showToast(
                msg: "Login Sucessfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is ErrorLoginState) {
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.noHeader,
              body: const Center(
                child: Text(
                  'uncorrert Username or Password',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              btnOkOnPress: () {},
            ).show();
          }
        },
        builder: (context, state) {
          return MaterialButton(
            // height: AppSettings.height * 0.08,
            onPressed: () async {
              AuthCubit.get(context).login(
                  email: emailController.text,
                  password: passwordController.text);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: kMainColor,
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
