import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/login/login_bloc.dart';
import 'package:truthordare/components/BuildTextField.dart';
import 'package:truthordare/components/DialogTextOnly.dart';
import 'package:truthordare/constants/Colors.dart';
import 'package:truthordare/constants/Dictionary.dart';
import 'package:truthordare/constants/route_paths.dart';
import 'package:truthordare/service_locator.dart';

class Register extends StatelessWidget {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => sl<LoginBloc>(),
        child: BlocListener<LoginBloc, LoginState>(
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
            } else if (state is RegisterSuccess) {
              showDialog(
                context: (context),
                builder: (context)=>DialogTextOnly(title: "Registrasi Berhasil",description: "Silahkan login dengan akun yang sudah didaftarkan", buttonText: "Login", onOkPressed: (){
                  Navigator.pushNamedAndRemoveUntil(
                      context, loginRoute, (route) => route.isCurrent);
                })
              );
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
          },
          child: BuildForm(
              form: _form,
              username: username,
              email: email,
              nama: nama,
              password: password,
              confirmPassword: confirmPassword),
        ),
      ),
    );
  }
}

class BuildForm extends StatefulWidget {
  const BuildForm({
    Key key,
    @required GlobalKey<FormState> form,
    @required this.username,
    @required this.email,
    @required this.nama,
    @required this.password,
    @required this.confirmPassword,
  })  : _form = form,
        super(key: key);

  final GlobalKey<FormState> _form;
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController nama;
  final TextEditingController password;
  final TextEditingController confirmPassword;

  @override
  _BuildFormState createState() => _BuildFormState();
}

class _BuildFormState extends State<BuildForm> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: widget._form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildTextField(
                controller: widget.username,
                validation: (value) {
                  if (value.toString().isEmpty) {
                    return "Username wajib diisi";
                  }
                  return null;
                },
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
                controller: widget.email,
                validation: (value) {
                  if (value.toString().isEmpty) {
                    return "Email wajib diisi";
                  }
                  return null;
                },
                title: "Email",
                textInputType: TextInputType.emailAddress,
                hintText: 'Masukkan email',
                roundedBorder: 6,
                isEdit: true,
                textCapitalization: TextCapitalization.none,
              ),
              SizedBox(
                height: 15,
              ),
              BuildTextField(
                validation: (value) {
                  if (value.toString().isEmpty) {
                    return "Nama Lengkap wajib diisi";
                  }
                  return null;
                },
                controller: widget.nama,
                title: "Nama Lengkap",
                hintText: 'Masukkan nama lengkap',
                roundedBorder: 6,
                isEdit: true,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(
                height: 15,
              ),
              BuildTextField(
                validation: (value) {
                  if (value.toString().isEmpty) {
                    return "Password wajib diisi";
                  }
                  return null;
                },
                controller: widget.password,
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
              BuildTextField(
                validation: (value) {
                  if (value.toString().isEmpty) {
                    return "Ulangi password wajib diisi";
                  } else if (value.toString() != widget.password.text) {
                    return "Password tidak sama";
                  }
                  return null;
                },
                controller: widget.confirmPassword,
                title: "Ulangi Password",
                hintText: 'ulangi password',
                roundedBorder: 6,
                textCapitalization: TextCapitalization.none,
                obsecureText: true,
                isEdit: true,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: RaisedButton(
                  elevation: 0,
                  padding: EdgeInsets.all(0.0),
                  color: ColorBase.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (widget._form.currentState.validate()) {
                      _loginBloc.add(RegisterPressed(
                          username: widget.username.text,
                          password: widget.password.text,
                          email: widget.email.text,
                          nama: widget.nama.text));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
