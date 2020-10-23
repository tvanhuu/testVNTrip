import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testExample1/src/bloc/authentication/AuthenticationBloc.dart';
import 'package:testExample1/src/helpers/Dimension.dart';
import 'package:testExample1/src/helpers/index.dart';
import 'package:testExample1/src/widgets/DialogLoading.dart';

import 'bloc/bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();

    loginBloc = LoginBloc(
      authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        cubit: loginBloc,
        listener: (context, state) {
          if (state is LoginLoading) {
            dialogLoading(context);
          }

          if (state is LoginSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
          }

          if (state is LoginFailure) {
            Navigator.pop(context);
          }
        },
        child: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width(context, 16)),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          colors: [
            HexColor("#F04F5F"),
            HexColor("#FBB731"),
          ],
          begin: Alignment.topCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildHeader(),
            SizedBox(height: getHeight(context) * 0.1),
            buildTextInput("Số điện thoại"),
            SizedBox(height: height(context, 21)),
            buildTextInput("mật khẩu", obscureText: true),
            SizedBox(height: height(context, 32)),
            buildBtnLogin()
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 25,
          ),
        ),
        SizedBox(height: height(context, 21)),
        Text(
          "Đăng nhập",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildBtnLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
          onPressed: () => loginBloc..add(LoginRequested()),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height(context, 16),
              horizontal: width(context, 20),
            ),
            child: Text(
              "Đăng nhập".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          color: HexColor("#E56024"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        TextButton(
          onPressed: () => loginBloc..add(LoginRequested()),
          child: Text(
            "Quên mật khẩu?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  Widget buildTextInput(String label, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: height(context, 10)),
        TextField(
          controller: TextEditingController()..text = '0988888869',
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(.3),
          ),
        ),
      ],
    );
  }
}
