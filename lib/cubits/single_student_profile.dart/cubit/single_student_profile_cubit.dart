import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../repos/dio_helper.dart';
import '../../../repos/end_points.dart';

part 'single_student_profile_state.dart';

class SingleStudentProfileCubit extends Cubit<SingleStudentProfileState> {
  SingleStudentProfileCubit() : super(SingleStudentProfileInitial());

  static SingleStudentProfileCubit get(context) => BlocProvider.of(context);

  //update Profile
}
