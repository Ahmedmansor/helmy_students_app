import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helmy/core/utils/navigation.dart';
import 'package:helmy/cubits/dash_board/cubit/dash_board_cubit.dart';
import 'package:helmy/repos/colors.dart';
import 'package:helmy/views/dash_board/data/models/student_model.dart';
import 'package:helmy/views/dash_board/presentation/views/add_student_screen.dart';
import '../../../core/utils/app_settings.dart';
import 'views/single_student_profile.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashBoardCubit, DashBoardState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              NavigationUtils.goTo(context, const AddStudentScreen());
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const Text('DashBoard'),
          ),
          body: BlocBuilder<DashBoardCubit, DashBoardState>(
            builder: (context, state) {
              return state is LoadingGetStudentsState
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        AppSettings.heightSpace(amountHeight: 0.02),
                        const CustomSearchBar(),
                        AppSettings.heightSpace(amountHeight: 0.02),
                        Text(
                            'Numbeers Of Searched   Students: ${DashBoardCubit.get(context).filteredStudentsList.length}'),
                        AppSettings.heightSpace(amountHeight: 0.02),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: DashBoardCubit.get(context)
                                    .filteredStudentsList
                                    .isEmpty
                                ? DashBoardCubit.get(context)
                                        .studentModel!
                                        .students!
                                        .length ??
                                    0
                                : DashBoardCubit.get(context)
                                    .filteredStudentsList
                                    .length,
                            itemBuilder: (context, index) {
                              var dashBoardCubit = DashBoardCubit.get(context)
                                  .studentModel!
                                  .students![index];
                              return _listTile(
                                  dashBoardCubit = DashBoardCubit.get(context)
                                          .filteredStudentsList
                                          .isEmpty
                                      ? dashBoardCubit
                                      : DashBoardCubit.get(context)
                                          .filteredStudentsList[index],
                                  context);
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        );
      },
    );
  }

  Widget _listTile(Students dashBoardCubit, BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationUtils.goTo(
            context,
            SingleStudentProfile(
              dashBoardCubit: dashBoardCubit,
            ));
      },
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          DashBoardCubit.get(context).deleteStudent(
            id: dashBoardCubit.id!,
          );
        },
        background: Container(
          color: Colors.red,
          padding: const EdgeInsets.only(left: 16, top: 16),
          constraints: const BoxConstraints.expand(),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
        ),
        child: ListTile(
          title: Text(
            dashBoardCubit.name.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            dashBoardCubit.studentId.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          leading: CircleAvatar(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(dashBoardCubit.studentImage.toString()),
            ),
          ),
          trailing: IconButton(
              onPressed: () {
                DashBoardCubit.get(context).deleteStudent(
                  id: dashBoardCubit.id!,
                );
              },
              icon: const Icon(
                Icons.delete,
                size: 40,
                color: kMainColor,
              )),
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        onChanged: (input) {
          DashBoardCubit.get(context).filteredStudents(input: input);
        },
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            labelText: "Search",
            // suffixIcon: const Icon(Icons.clear),
            // contentPadding: EdgeInsets.zero,
            fillColor: Colors.grey.withOpacity(0.2),
            filled: true),
      ),
    );
  }
}
