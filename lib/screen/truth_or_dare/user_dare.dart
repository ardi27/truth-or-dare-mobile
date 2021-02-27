import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/truth_or_dare_bloc.dart';

import 'package:truthordare/blocs/truth_or_dare/user_tod/user_tod_bloc.dart';
import 'package:truthordare/components/EmptyData.dart';
import 'package:truthordare/constants/Colors.dart';
import 'package:truthordare/constants/Dictionary.dart';
import 'package:truthordare/service_locator.dart';

class UserDare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserTodBloc>(
      create: (context) => sl<UserTodBloc>()..add(GetUserDare()),
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
            }
            else if(state is TodDeleted){
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
                        "Dare berhasil dihapus",
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
            }else if(state is UserDareloaded){
              return BuildUserDare(state: state,);
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

class BuildUserDare extends StatefulWidget {
  final UserDareloaded state;
  const BuildUserDare({
    Key key, this.state,
  }) : super(key: key);

  @override
  _BuildUserDareState createState() => _BuildUserDareState();
}

class _BuildUserDareState extends State<BuildUserDare> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.state.userDare.length,
      shrinkWrap: true,
      itemBuilder: (context,index)=>Column(
        children: [
          ListTile(
            leading: Icon(Icons.directions_run),
            title: Text(widget.state.userDare[index].dare),
            subtitle: Text(widget.state.userDare[index].level),
            trailing: InkWell(
              child: Icon(Icons.delete_outline,color: ColorBase.darkRed,),
              onTap: (){
                BlocProvider.of<UserTodBloc>(context).add(DeleteUserTod(type: "dare",uuid:widget.state.userDare[index].uuid));
              },
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
