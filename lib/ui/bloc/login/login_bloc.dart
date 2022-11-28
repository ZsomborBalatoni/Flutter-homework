import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginForm()) {
    Response loginToken;

    on<LoginSubmitEvent>(((event, emit) async {
      try {
        if (state != LoginLoading()) {
          emit(LoginLoading());
          Map<String, String> map = {
            'email': event.email,
            'password': event.password,
          };
          loginToken = await GetIt.I<Dio>().post('/login', data: map);
          if (event.rememberMe) {
            GetIt.I<SharedPreferences>()
                .setString('token', loginToken.data['token']);
          }
          GetIt.I<Dio>().options.headers['Authorization'] =
              'Bearer ${loginToken.data['token']}';

          emit(LoginSuccess());
          emit(LoginForm());
        }
      } on DioError catch (e) {
        emit(LoginError(e.response?.data['message']));
        emit(LoginForm());
      }
    }));

    on<LoginAutoLoginEvent>(((event, emit) async {
      if (GetIt.I<SharedPreferences>().containsKey('token')) {
        var token = GetIt.I<SharedPreferences>().getString('token');

        if (token != null) {
          GetIt.I<Dio>().options.headers['Authorization'] = 'Bearer $token';
          emit(LoginSuccess());
        }
      }
    }));
  }
}
