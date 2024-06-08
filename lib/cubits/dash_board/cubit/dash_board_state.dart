part of 'dash_board_cubit.dart';

@immutable
sealed class DashBoardState {}

final class DashBoardInitial extends DashBoardState {}

//------------------------------------------------------------------------------
final class LoadingGetStudentsState extends DashBoardState {}

final class SucessGetStudentsState extends DashBoardState {}

final class ErrorGetStudentsState extends DashBoardState {}

//------------------------------------------------------------------------------
final class LoadingUpdateProfileState extends DashBoardState {}

final class SucessUpdateProfileState extends DashBoardState {}

final class ErrorUpdateProfileState extends DashBoardState {}

//------------------------------------------------------------------------------
final class LoadingAddStudentState extends DashBoardState {}

final class SucessAddStudentState extends DashBoardState {}

final class ErrorAddStudentState extends DashBoardState {}

//------------------------------------------------------------------------------
final class CamereState extends DashBoardState {}

final class GalleryState extends DashBoardState {}

//------------------------------------------------------------------------------
final class SucessFilterStudentsState extends DashBoardState {}
