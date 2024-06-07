import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helmy/core/utils/app_settings.dart';
import 'package:helmy/cubits/dash_board/cubit/dash_board_cubit.dart';
import 'package:helmy/views/dash_board/presentation/views/single_student_profile.dart';

import '../../../../core/utils/navigation.dart';
import '../../../../repos/const.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: BlocBuilder<DashBoardCubit, DashBoardState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppSettings.heightSpace(amountHeight: 0.02),
                  TextFormField(
                    onChanged: (input) {
                      DashBoardCubit.get(context)
                          .filteredStudents(input: input);
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        labelText: "Search",
                        suffixIcon: const Icon(Icons.clear),
                        // contentPadding: EdgeInsets.zero,
                        fillColor: Colors.grey.withOpacity(0.2),
                        filled: true),
                  ),
                  AppSettings.heightSpace(amountHeight: 0.02),
                  AppSettings.heightSpace(amountHeight: 0.02),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: DashBoardCubit.get(context)
                          .filteredStudentsList
                          .length,
                      itemBuilder: (context, index) {
                        var dashBoardCubit = DashBoardCubit.get(context)
                            .filteredStudentsList[index];
                        return ListTile(
                          title: Text(dashBoardCubit.name.toString()),
                          subtitle: Text(dashBoardCubit.studentId.toString()),
                          leading: CircleAvatar(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                  dashBoardCubit.studentImage.toString()),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
