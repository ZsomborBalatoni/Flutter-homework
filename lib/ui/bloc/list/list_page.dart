import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_homework/ui/bloc/list/list_bloc.dart';
import 'package:flutter_homework/ui/bloc/login/login_bloc.dart';
import 'package:flutter_homework/ui/bloc/login/login_page.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListPageBloc extends StatefulWidget {
  const ListPageBloc({super.key});

  @override
  State<ListPageBloc> createState() => _ListPageBlocState();
}

class _ListPageBlocState extends State<ListPageBloc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Lista'),
        backgroundColor: Colors.blueGrey[200],
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: (() {
            Navigator.of(context).pushReplacementNamed('/login');
            const LoginPageBloc();
          }),
        ),
      ),
      body: Center(
        child: BlocConsumer<ListBloc, ListState>(
          listener: (context, state) {
            if (state is ListError) {
              buildListError(state.message);
            }
          },
          builder: (context, state) {
            if (state is ListLoading) {
              return buildListLoading();
            } else if (state is ListLoaded) {
              return buildListLoaded();
            } else {
              return buildListInitial();
            }
          },
        ),
      ),
    );
  }

  Widget buildListInitial() {
    return Scaffold(
      backgroundColor: Colors.blueGrey[500],
      body: SafeArea(
        child: Center(
          child: Form(
            child: Column(children: const [
              SizedBox(height: 40),
              Text('sddsd'),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildListLoading() {
    return Scaffold(
      backgroundColor: Colors.blueGrey[500],
      body: SafeArea(
        child: Center(
          child: Form(
            child: Column(children: const [
              SizedBox(height: 40),
              Text('sddsd'),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildListLoaded() {
    return Scaffold(
      backgroundColor: Colors.blueGrey[500],
      body: SafeArea(
        child: Center(
          child: Form(
            child: Column(children: const [
              SizedBox(height: 40),
              Text('sddsd'),
            ]),
          ),
        ),
      ),
    );
  }

  ScaffoldFeatureController buildListError(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message),
        ),
      );
}
