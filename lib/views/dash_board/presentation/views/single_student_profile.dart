import 'package:flutter/material.dart';
import 'package:helmy/core/utils/app_settings.dart';
import 'package:helmy/core/utils/navigation.dart';
import 'package:helmy/core/widgets/custom_button.dart';
import 'package:helmy/views/dash_board/presentation/views/edit_single_student_profile.dart';

import '../../data/models/student_model.dart';

class SingleStudentProfile extends StatelessWidget {
  const SingleStudentProfile({
    super.key,
    required this.dashBoardCubit,
  });
  final Students dashBoardCubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(dashBoardCubit.name.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    dashBoardCubit.studentImage.toString(),
                  ),
                ),
              ),
              AppSettings.heightSpace(amountHeight: 0.02),
              Text(
                ' id: ${dashBoardCubit.id!}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              // Text(
              //   dashBoardCubit.name!,
              //   style:
              //       const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              // AppSettings.heightSpace(amountHeight: 0.01),
              Text(
                'student Id: ${dashBoardCubit.studentId!}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'class Name: ${dashBoardCubit.className!}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                ' year: ${dashBoardCubit.year!}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              // AppSettings.heightSpace(amountHeight: 0.1),

              SizedBox(
                width: AppSettings.width * 0.4,
                child: CustomGeneralButton(
                  text: 'Edit',
                  onTap: () {
                    NavigationUtils.goTo(
                        context,
                        EditSingleStudentProfile(
                          dashBoardCubit: dashBoardCubit,
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
