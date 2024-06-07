import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helmy/core/utils/navigation.dart';

import '../../../../../cubits/dash_board/cubit/dash_board_cubit.dart';

class TakeImage extends StatelessWidget {
  const TakeImage({super.key});

  @override
  Widget build(BuildContext context) {
    var dashBoardCubit = DashBoardCubit.get(context);

    return BlocBuilder<DashBoardCubit, DashBoardState>(
      builder: (context, state) {
        return Column(children: [
          dashBoardCubit.file == null
              ? Stack(
                  children: [
                    const CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: MaterialButton(
                                            color: Colors.grey,
                                            onPressed: () async {
                                              await dashBoardCubit.pickCamera();
                                              // ignore: use_build_context_synchronously
                                              NavigationUtils.offScreen(
                                                  context);
                                            },
                                            child: const Text("Camera")),
                                      ),
                                      // Expanded(
                                      //   child: MaterialButton(
                                      //       color: Colors.grey,
                                      //       onPressed: () async {
                                      //         dashBoardCubit.image =
                                      //             await picker.pickImage(
                                      //                 source: ImageSource.camera);
                                      //         setState(() {});
                                      //       },
                                      //       child: const Text("camera")),
                                      // ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.camera_outlined)),
                    )
                  ],
                )
              : CircleAvatar(
                  radius: 55,
                  backgroundImage: FileImage(File(dashBoardCubit.file!.path)),
                ),
        ]);
      },
    );
  }
}
