part of 'admin_bloc.dart';

@immutable
sealed class AdminEvent {}

final class ClearAdmin extends AdminEvent {}

final class SetAdmin extends AdminEvent {
  final Admin admin;

  SetAdmin({required this.admin});
}
