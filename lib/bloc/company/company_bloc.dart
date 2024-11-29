import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/model/company/company.dart';
import 'package:meta/meta.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(const CompanyInitial()) {
    on<SetCompany>((event, emit) {
      emit(CompanyLoaded(company: event.company));
    });
  }
}
