part of 'admin_bloc.dart';

@immutable
sealed class AdminState {
  final Admin? admin;

  const AdminState({required this.admin});
}

final class AdminInitial extends AdminState {
  const AdminInitial(): super(admin: null);
}

class AdminLoaded extends AdminState {
  const AdminLoaded({required super.admin});
}
