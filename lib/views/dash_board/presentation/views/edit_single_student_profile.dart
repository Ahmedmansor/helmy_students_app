import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helmy/core/utils/navigation.dart';
import 'package:helmy/cubits/dash_board/cubit/dash_board_cubit.dart';
import 'package:helmy/repos/colors.dart';

import '../../../../core/utils/app_settings.dart';
import '../../../../repos/const.dart';
import '../../data/models/student_model.dart';
import 'widgets/profile_text_field.dart';

// ignore: must_be_immutable
class EditSingleStudentProfile extends StatelessWidget {
  const EditSingleStudentProfile({super.key, required this.dashBoardCubit});
  // final int index;
  final Students dashBoardCubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      body: ProfileCard(
        dashBoardCubit: dashBoardCubit,
      ),
    );
  }
}

// ignore: must_be_immutable
class ProfileCard extends StatelessWidget {
  ProfileCard({super.key, required this.dashBoardCubit});
  var nameController = TextEditingController();
  var studentIdController = TextEditingController();
  var yearController = TextEditingController();
  var classNameController = TextEditingController();

  // final int index;
  final Students dashBoardCubit;

  @override
  Widget build(BuildContext context) {
    // var profileItem = DashBoardCubit.get(context).studentModel;

    // ignore: prefer_const_constructors
    nameController.text = dashBoardCubit.name!;
    studentIdController.text = dashBoardCubit.studentId!;
    yearController.text = dashBoardCubit.year.toString();
    classNameController.text = dashBoardCubit.className!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocConsumer<DashBoardCubit, DashBoardState>(
        listener: (context, state) {
          if (state is SucessUpdateProfileState) {
            NavigationUtils.offScreen(context);
            NavigationUtils.offScreen(context);

            Fluttertoast.showToast(
                msg: "Profile Data Changed Sucessfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: kMainColor,
                textColor: Colors.black,
                fontSize: 16.0);
          }

          if (state is ErrorUpdateProfileState) {
            Fluttertoast.showToast(
                msg: 'ERROR',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.black,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          return state is LoadingUpdateProfileState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(dashBoardCubit.studentImage!),
                      ),
                    ),
                    SizedBox(height: AppSettings.height * 0.01),
                    const Text(
                      'name',
                      style: ThemeText.iconsNameBold,
                    ),
                    profileTextFormField(
                        name: 'name',
                        iconData: Icons.person,
                        controller: nameController),
                    SizedBox(
                      height: AppSettings.height * 0.02,
                    ),
                    const Text(
                      'student Id',
                      style: ThemeText.iconsNameBold,
                    ),
                    profileTextFormField(
                        name: 'student Id',
                        // iconData: Icons.email_outlined,
                        controller: studentIdController),
                    SizedBox(
                      height: AppSettings.height * 0.02,
                    ),
                    const Text(
                      'year',
                      style: ThemeText.iconsNameBold,
                    ),
                    profileTextFormField(
                        name: 'year',
                        // iconData: Icons.phone_android_outlined,
                        controller: yearController),
                    SizedBox(
                      height: AppSettings.height * 0.02,
                    ),
                    const Text(
                      'class Name',
                      style: ThemeText.iconsNameBold,
                    ),
                    profileTextFormField(
                        name: 'class Name',
                        // iconData: Icons.phone_android_outlined,
                        controller: classNameController),
                    SizedBox(
                      height: AppSettings.height * 0.05,
                    ),
                    Center(
                      child: BlocBuilder<DashBoardCubit, DashBoardState>(
                        builder: (context, state) {
                          return state is LoadingUpdateProfileState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : MaterialButton(
                                  onPressed: () {
                                    DashBoardCubit.get(context).updateProfile(
                                        name: nameController.text,
                                        studentId: studentIdController.text,
                                        year: int.parse(yearController.text),
                                        className: classNameController.text,
                                        id: dashBoardCubit.id!);
                                    debugPrint(
                                        'thd id in the button${dashBoardCubit.id}');
                                  },
                                  color: kMainColor,
                                  child: const Text('Update Data'),
                                );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
