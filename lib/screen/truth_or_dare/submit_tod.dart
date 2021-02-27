import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/authentication/auth_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/truth_or_dare_bloc.dart';
import 'package:truthordare/components/BuildTextField.dart';
import 'package:truthordare/constants/Colors.dart';
import 'package:truthordare/constants/Dictionary.dart';
import 'package:truthordare/constants/route_paths.dart';
import 'package:truthordare/service_locator.dart';

class SubmitTod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(AppStarted()),
        ),
        BlocProvider<TruthOrDareBloc>(create: (context)=>sl<TruthOrDareBloc>())
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Submit ToD"),
        ),
        body: MultiBlocListener(listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthUnauthenticated) {
                Navigator.pop(context);
                Navigator.pushNamed(context, homeRoute);
                Navigator.pushNamed(context, loginRoute);
              }
            },
          ),

        ], child: FormTod()),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class FormTod extends StatefulWidget {
  const FormTod({
    Key key,
  }) : super(key: key);

  @override
  _FormTodState createState() => _FormTodState();
}

class _FormTodState extends State<FormTod> {
  List groupValue=['truth','dare'];
  List<DropdownMenuItem> levelItems;
  String valueLevel='';
  String type='truth';
  TextEditingController tod=TextEditingController();
  GlobalKey<FormState> _form=GlobalKey();
  @override
  void initState() {

    super.initState();
    levelItems=[
      DropdownMenuItem(child: Text("Easy"),value: 'easy',),
      DropdownMenuItem(child: Text("Medium"),value: 'medium',),
      DropdownMenuItem(child: Text("Hard"),value: 'hard',),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<TruthOrDareBloc,TruthOrDareState>(
      listener: (context,state){
        if(state is TodError){
          return Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: Row(
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: Text(state.errMessage.split(Dictionary.exeption).last,style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ));
        }else if(state is TodAdded){
          _form.currentState.reset();
          tod.text="";
          return Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: Text("Truth or dare Succesfully added",style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ));
        }else if(state is TodLoading){
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              content: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Container(
                    margin: EdgeInsets.only(left: 15.0),
                    child: Text(Dictionary.pleaseWait),
                  )
                ],
              ),
            ),
          );
        }else{
          Scaffold.of(context).hideCurrentSnackBar();
        }
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                BuildTextField(
                  controller: tod,
                  title: "Truth or Dare",
                  hintText: 'Masukkan Isi Truth or Dare',
                  roundedBorder: 6,
                  isEdit: true,
                  validation: (String value){
                    if(value.isEmpty){
                      return "Truth or dare harus diisi";
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.none,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Tipe",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                RadioListTile(
                  groupValue: type,
                  value: groupValue[0],
                  activeColor: ColorBase.kPrimaryColor,
                  title: Text("Truth"),
                  onChanged: (value) {
                    type=value;
                    setState(() {

                    });
                  },
                ),
                RadioListTile(
                  activeColor: ColorBase.kPrimaryColor,
                  groupValue: type,
                  value: groupValue[1],
                  title: Text("Dare"),
                  onChanged: (value) {
                    type=value;
                    setState(() {

                    });
                  },
                ),
                DropdownButtonFormField(
                  validator: (value){
                    if(value==null){
                      return "Level harus diisi";
                    }
                    return null;
                  },
                  items: levelItems,
                  isDense: true,
                  onChanged: (value) {
                    valueLevel=value;
                  },
                  hint: Text("Pilih Level"),

                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 50.0,
                  child: RaisedButton(
                    elevation: 0,
                    padding: EdgeInsets.all(0.0),
                    color: ColorBase.kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      if(_form.currentState.validate()){
                        BlocProvider.of<TruthOrDareBloc>(context).add(SubmitTruthOrDare(level:valueLevel,type: type,value: tod.text ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
