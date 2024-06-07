part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class ChangeVisabilityState extends AuthState {}

final class LoginInValidState extends AuthState {}

final class LoginValidState extends AuthState {}

final class SucessLoginState extends AuthState {}

final class ErrorLoginState extends AuthState {}
