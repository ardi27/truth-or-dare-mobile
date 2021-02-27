import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/login/login_bloc.dart';
import 'package:truthordare/constants/Colors.dart';
import 'package:truthordare/components/BuildTextField.dart';
import 'package:truthordare/constants/Dictionary.dart';
import 'package:truthordare/constants/Strings.dart';
import 'package:truthordare/constants/route_paths.dart';
import 'package:truthordare/service_locator.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => sl<LoginBloc>(),
      child: Scaffold(
        body: BuildForm(),
      ),
    );
  }
}

class BuildForm extends StatefulWidget {
  @override
  _BuildFormState createState() => _BuildFormState();
}

class _BuildFormState extends State<BuildForm> {
  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              content: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Container(
                    margin: EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Processing",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, homeRoute, (route) => route.isCurrent);
        } else if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              content: Row(
                children: <Widget>[
                  Icon(
                    Icons.dangerous,
                    color: Colors.white,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.0),
                    child: Text(
                      state.message.split(Dictionary.exeption).last,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      Strings.appName,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: ColorBase.kPrimaryColor),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      Strings.tagLine,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    BuildTextField(
                      controller: username,
                      title: "Username",
                      hintText: 'Masukkan username',
                      roundedBorder: 6,
                      isEdit: true,
                      textCapitalization: TextCapitalization.none,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    BuildTextField(
                      controller: password,
                      title: "Password",
                      hintText: 'Masukkan password',
                      roundedBorder: 6,
                      textCapitalization: TextCapitalization.none,
                      obsecureText: true,
                      isEdit: true,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  child: RaisedButton(
                    elevation: 0,
                    padding: EdgeInsets.all(0.0),
                    color: ColorBase.kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _loginBloc.add(LoginPressed(
                          username: username.text, password: password.text));
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text.rich(
                  TextSpan(text: "Belum punya akun? ", children: [
                    TextSpan(
                        text: "Daftar disini",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorBase.kPrimaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, registerRoute);
                          })
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
