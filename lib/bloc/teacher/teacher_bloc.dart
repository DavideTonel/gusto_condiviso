import 'package:bloc/bloc.dart';
import 'package:gusto_condiviso/model/teacher/teacher.dart';
import 'package:meta/meta.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  TeacherBloc() : super(const TeacherInitial()) {
    on<SetTeacher>((event, emit) {
      emit(TeacherLoaded(teacher: event.teacher));
    });
  }
}
