import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/truth_or_dare_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/user_tod/user_tod_bloc.dart';
import 'package:truthordare/components/DialogTextOnly.dart';
import 'package:truthordare/components/EmptyData.dart';
import 'package:truthordare/constants/Colors.dart';
import 'package:truthordare/constants/Dictionary.dart';
import 'package:truthordare/service_locator.dart';

class UserTruth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserTodBloc>(
      create: (context) => sl<UserTodBloc>()..add(GetUserTruth()),
      child: Scaffold(
        body: BlocConsumer<UserTodBloc, UserTodState>(
          listener: (context, state) {
            if (state is UserTodFailure) {
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
                      child: Text(
                        state.message.split(Dictionary.exeption).last,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ));
            }else if(state is TodDeleted){
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
                      child: Text(
                        "Truth berhasil dihapus",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ));
            }
          },
          builder: (context, state) {
            if (state is UserTodLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if(state is UserTruthLoaded){
              return BuildListTruth(state: state,);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class BuildListTruth extends StatefulWidget {
  final UserTruthLoaded state;
  const BuildListTruth({
    this.state,
    Key key,
  }) : super(key: key);

  @override
  _BuildListTruthState createState() => _BuildListTruthState();
}

class _BuildListTruthState extends State<BuildListTruth> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.state.userTruth.length,
      shrinkWrap: true,
      itemBuilder: (context,index)=>Column(
        children: [
          ListTile(
            leading: Icon(Icons.directions_run),
            title: Text(widget.state.userTruth[index].truth),
            subtitle: Text(widget.state.userTruth[index].level),
            trailing: InkWell(
              child: Icon(Icons.delete_outline,color: ColorBase.darkRed,),
              onTap: (){
                BlocProvider.of<UserTodBloc>(context).add(DeleteUserTod(type: "truth",uuid:widget.state.userTruth[index].uuid));
              },
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
