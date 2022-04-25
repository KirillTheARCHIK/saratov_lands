import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:saratov_lands/bloc/AuthBloc/User.dart';
import 'package:saratov_lands/constants.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(Unauthorized()) {
    on<Logout>(
      (event, emit) {
        emit(Unauthorized());
      },
    );
    on<Login>(
      (event, emit) async {
        var userDB = await FirebaseFirestore.instance
            .collection('users')
            .where('login', isEqualTo: event.login)
            .get()
            .then((value) => value.docs.isNotEmpty ? value.docs.first : null);
        if (userDB == null) {
          emit(UnauthorizedWithError(AuthExeptions.noUser));
          return;
        }
        if (userDB.data()['password'] != event.password) {
          emit(UnauthorizedWithError(AuthExeptions.wrongPassword));
          return;
        }

        emit(Authorized(
          user: User(
            id: userDB.id,
            login: userDB.data()['login'],
            password: userDB.data()['password'],
          ),
        ));
      },
    );
  }
}
