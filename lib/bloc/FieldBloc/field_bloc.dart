import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'field_event.dart';
part 'field_state.dart';

class FieldBloc extends Bloc<FieldEvent, FieldState> {
  FieldBloc() : super(FieldInitial()) {
    on<FieldEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
