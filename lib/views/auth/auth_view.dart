import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helmy/views/auth/widgets/login_button.dart';

import '../../core/utils/app_settings.dart';
import '../../cubits/auth/cubit/auth_cubit.dart';
import '../../repos/colors.dart';
import '../../repos/const.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            height: AppSettings.height,
            width: AppSettings.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/v617batch2-bb-02-technology.jpg'),
                  fit: BoxFit.fill),
            ),
            child: Column(children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 50),
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    'Login To Continue ....',
                    style: ThemeText.boardingScreenBodysmall,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  // height: AppSettings.height,
                  width: AppSettings.width,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.90),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      Form(
                        key: AuthCubit.get(context).keyLogin,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: AppSettings.height * 0.050,
                            ),
                            Text(
                              'Login',
                              style: ThemeText.boardingScreenBody
                                  .copyWith(color: Colors.black),
                            ),
                            // const Text(
                            //   'Please login to find your dream job',
                            //   style: ThemeText.boardingScreenBodysmall,
                            // ),
                            SizedBox(
                              height: AppSettings.height * 0.05,
                            ),
                            TextFormField(
                              controller: emailController,
                              onChanged: (value) {
                                // chat gpt: the set state
                                AuthCubit.get(context).validateFormLogin(
                                    email: value,
                                    password: passwordController
                                        .text); // _key.currentState!.validate();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email can't be empty";
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return "email formate is not correct";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "email",
                                prefixIcon: const Icon(Icons.person_2_outlined),
                              ),
                            ),
                            SizedBox(
                              height: AppSettings.height * 0.03,
                            ),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return TextFormField(
                                  controller: passwordController,
                                  onChanged: (value) {
                                    // chat gpt: the set state

                                    AuthCubit.get(context).validateFormLogin(
                                        email: emailController.text,
                                        password:
                                            value); // _key.currentState!.validate();
                                  },
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return "password must be at least 8 characters";
                                    } else if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                        .hasMatch(value)) {
                                      return "password formate is not correct";
                                    }
                                    return null;
                                  },
                                  obscureText:
                                      AuthCubit.get(context).isPassword,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: "Password",
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        AuthCubit.get(context)
                                            .changeVisablity();
                                      },
                                      icon: Icon(
                                          AuthCubit.get(context).isPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: AppSettings.defultSize * 1,
                            ),
                            LoginButton(
                                emailController: emailController,
                                passwordController: passwordController),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
