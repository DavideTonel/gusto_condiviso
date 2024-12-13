import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/model/admin/admin.dart';
import 'package:meta/meta.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(const AdminInitial()) {
    on<SetAdmin>((event, emit) {
      emit(AdminLoaded(admin: event.admin));
    });
  }
}
