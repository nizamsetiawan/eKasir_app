// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:ekasir_app/data/datasources/auth_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_bloc.freezed.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemoteDatasource _authRemoteDatasource;
  LogoutBloc(
    this._authRemoteDatasource,
  ) : super(_Initial()) {
    on<_Logout>((event, emit) async {
      emit(LogoutState.loading());
      final result = await _authRemoteDatasource.logout();
      result.fold((l) {
        emit(LogoutState.error(l));
      }, (r) {
        emit(LogoutState.success());
      });
    });
  }
}
