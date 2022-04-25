// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:saratov_lands/bloc/AuthBloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextStyle textStyle = TextStyle(
    fontSize: 20,
  );
  TabController? tabController;

  GlobalKey loginFormKey = GlobalKey<FormState>();
  GlobalKey registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle textButtonStyle =
        (Theme.of(context).textButtonTheme.style ?? ButtonStyle()).copyWith(
      overlayColor: MaterialStateProperty.all(Color.fromARGB(10, 0, 0, 0)),
      shape: MaterialStateProperty.all(RoundedRectangleBorder()),
    );

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnauthorizedWithError) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorText),
            backgroundColor: Colors.red,
          ));
        } else if (state is Authorized) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Успешная авторизация'),
            backgroundColor: Colors.green,
          ));
        }
      },
      builder: (context, state) {
        AuthBloc authBloc = context.read<AuthBloc>();

        return Scaffold(
          appBar: AppBar(title: Text('Login')),
          body: Center(
            heightFactor: 2,
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 300,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        //LOGIN
                        Form(
                          key: loginFormKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Text(
                                  'Вход',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Text(
                                  'Логин',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 40, right: 40),
                                child: TextField(
                                  controller: loginController,
                                  style: textStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Text('Пароль'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 40, right: 40),
                                child: TextField(
                                  controller: passwordController,
                                  style: textStyle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(),
                                child: ElevatedButton(
                                  child: Text('Войти как пользователь'),
                                  onPressed: () {
                                    authBloc.add(Login(
                                      login: loginController.text,
                                      password: passwordController.text,
                                    ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        //REGISTER
                        Column(
                          children: [
                            Expanded(child: Container()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              tabController!.animateTo(0);
                              setState(() {});
                            },
                            child: Text('Вход'),
                            style: textButtonStyle.copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                  tabController!.index == 0
                                      ? Color.fromARGB(0, 0, 0, 0)
                                      : Color.fromARGB(30, 0, 0, 0)),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              tabController!.animateTo(1);
                              setState(() {});
                            },
                            child: Text('Регистрация'),
                            style: textButtonStyle.copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                  tabController!.index == 1
                                      ? Color.fromARGB(0, 0, 0, 0)
                                      : Color.fromARGB(30, 0, 0, 0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
