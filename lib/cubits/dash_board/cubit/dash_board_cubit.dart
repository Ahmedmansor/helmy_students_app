import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../repos/dio_helper.dart';
import '../../../repos/end_points.dart';
import '../../../views/dash_board/data/models/student_model.dart';

part 'dash_board_state.dart';

class DashBoardCubit extends Cubit<DashBoardState> {
  DashBoardCubit() : super(DashBoardInitial());
  static DashBoardCubit get(context) => BlocProvider.of(context);

  StudentModel? studentModel;

  void getAllStudents() async {
    emit(LoadingGetStudentsState());
    await DioHelper.dio.get(getStudentsEndPoint).then((value) {
      if (value.statusCode == 200) {
        emit(SucessGetStudentsState());
        debugPrint('sucess get all Students');
        studentModel = StudentModel.fromJson(value.data);
        debugPrint('${studentModel!.students!.length}');
      } else {
        emit(ErrorGetStudentsState());
      }
    }).catchError((error) {
      emit(ErrorGetStudentsState());
      debugPrint(error.toString());
    });
  }

//Update Student
  updateProfile(
      {required String name,
      required int year,
      required String studentId,
      required String className,
      required int id}) async {
    debugPrint('in update ProfileMethod in CUBIT');
    emit(LoadingUpdateProfileState());
    await DioHelper.dio.put(
      // '$getStudentsEndPoint/+ $id',
      '$getStudentsEndPoint/$id',
      data: {
        "name": name,
        "studentId": studentId,
        'year': year,
        "className": className,
        // "id": id,
      },
    ).then((value) {
      debugPrint('$getStudentsEndPoint/$id');

      // debugPrint(value.data['status']);
      if (value.statusCode == 200) {
        debugPrint('in update Profile1');
        getAllStudents();
        emit(SucessUpdateProfileState());
      } else {
        emit(ErrorUpdateProfileState());
      }
    }).catchError((e) {
      emit(ErrorUpdateProfileState());

      debugPrint(e.toString());
    });
  }

  //Post Controllers
  var nameController = TextEditingController();
  var studentIdController = TextEditingController();
  var yearController = TextEditingController();
  var classNameController = TextEditingController();

  //Add Studrent
  void addStudent({
    required String name,
    required String studentId,
    required String className,
    required int year,
  }) async {
    emit(LoadingAddStudentState());
    String imageName = file!.path.split('/').last;
    debugPrint(imageName);

    FormData formData = FormData.fromMap({
      // 'files': [
      //   await MultipartFile.fromFile(file!.path, filename: imageName),
      // ],
      'name': name,
      'studentId': studentId,
      'year': year,
      'className': className,
      "studentImage":
          await MultipartFile.fromFile(file!.path, filename: imageName),
    });
    await DioHelper.dio.post(getStudentsEndPoint, data: formData).then((value) {
      if (value.statusCode == 201 || value.statusCode == 200) {
        emit(SucessAddStudentState());
        getAllStudents();
        debugPrint('in add Student');
      } else {
        emit(ErrorAddStudentState());
        debugPrint('in error add Student');
      }
    }).catchError((e) {
      emit(ErrorAddStudentState());
      debugPrint(e.toString());
    });
  }

  File? file;
  // XFile? image;

  Future pickCamera() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.camera);
    emit(CamereState());
    file = File(myfile!.path);
  }

  Future pickGallery() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(GalleryState());
    file = File(myfile!.path);
  }

  //filtered Students
  // List<Students> filteredStudentsList = [];

  // void filteredStudents({required String input}) {

  //   List<Students> allStudents = studentModel!.students!;

  //   filteredStudentsList = allStudents
  //       .where((element) =>
  //           element.name!.toLowerCase().contains(input.toLowerCase()) ||
  //           element.studentId!.contains(input.toLowerCase()))
  //       .toList();

  //   debugPrint(filteredStudentsList.length.toString());
  //   emit(SucessFilterStudentsState());
  // }
  List<Students> filteredStudentsList = [];

  void filteredStudents({required String input}) {
    List<Students> allStudents = studentModel!.students!;

    if (input.isEmpty) {
      filteredStudentsList = [];
    } else {
      filteredStudentsList = allStudents
          .where((element) =>
              element.name!.toLowerCase().contains(input.toLowerCase()) ||
              element.studentId!.contains(input.toLowerCase()))
          .toList();
    }

    debugPrint(filteredStudentsList.length.toString());
    emit(SucessFilterStudentsState());
  }

  //Delete Student
  void deleteStudent({required int id}) async {
    await DioHelper.dio.delete('$getStudentsEndPoint/$id').then((value) {
      if (value.statusCode == 200) {
        getAllStudents();
      }
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }
}
