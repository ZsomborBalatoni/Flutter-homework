import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_homework/network/user_item.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListInitial()) {
    Response users;

    on<ListLoadEvent>(
      (event, emit) async {
        try {
          if (state != ListLoading()) {
            emit(ListLoading());
            /*
            GetIt.I<Dio>().options.headers['Authorization'] =
                'Bearer ${GetIt.I<SharedPreferences>().getString('token')}';
                */
            users = await GetIt.I<Dio>().get('/users');
            List<UserItem> list = [];
            for (var i = 0; i < users.data.length; i++) {
              list.add(
                  UserItem(users.data[i]['name'], users.data[i]['avatarUrl']));
            }
            emit(ListLoaded(list));
          }
        } on DioError catch (e) {
          emit(ListError(e.response?.data['message']));
          //emit(ListInitial());
        }
      },
    );
  }
}
