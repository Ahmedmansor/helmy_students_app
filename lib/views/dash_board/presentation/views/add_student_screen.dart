import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helmy/views/dash_board/presentation/views/widgets/profile_text_field.dart';
import 'package:helmy/views/dash_board/presentation/views/widgets/take_image.dart';

import '../../../../core/utils/app_settings.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../cubits/dash_board/cubit/dash_board_cubit.dart';
import '../../../../repos/const.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Student'),
      ),
      body: BlocConsumer<DashBoardCubit, DashBoardState>(
        listener: (context, state) {
          if (state is SucessAddStudentState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Student Added Successfully'),
              backgroundColor: Colors.green,
            ));
            DashBoardCubit.get(context).nameController.clear();
            DashBoardCubit.get(context).studentIdController.clear();
            DashBoardCubit.get(context).yearController.clear();
            DashBoardCubit.get(context).classNameController.clear();
            DashBoardCubit.get(context).file = null;

            NavigationUtils.offScreen(context);
          }

          if (state is ErrorAddStudentState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('error ading Student'),
            ));
          }
        },
        builder: (context, state) {
          var dashBoardCubit = DashBoardCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Center(child: TakeImage()),
                  SizedBox(
                    height: AppSettings.height * 0.03,
                  ),
                  const Text(
                    'name',
                    style: ThemeText.iconsNameBold,
                  ),
                  profileTextFormField(
                      name: 'name',
                      iconData: Icons.person,
                      controller: dashBoardCubit.nameController),
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
                      controller: dashBoardCubit.studentIdController),
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
                      controller: dashBoardCubit.yearController),
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
                      controller: dashBoardCubit.classNameController),
                  SizedBox(
                    height: AppSettings.height * 0.02,
                  ),
                  CustomGeneralButton(
                    text: 'Add',
                    onTap: () {
                      DashBoardCubit.get(context).addStudent(

                          // file: dashBoardCubit.file,
                          className: dashBoardCubit.classNameController.text,
                          name: dashBoardCubit.nameController.text,
                          studentId: dashBoardCubit.studentIdController.text,
                          year: int.parse(dashBoardCubit.yearController.text));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
