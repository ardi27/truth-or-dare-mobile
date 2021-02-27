import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/truth_or_dare_bloc.dart';
import 'package:truthordare/service_locator.dart';
import 'package:truthordare/constants/Colors.dart';
import 'package:truthordare/constants/Dictionary.dart';
import 'package:truthordare/utilities/string_helper.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TruthOrDareBloc>(
      create: (context) => sl<TruthOrDareBloc>()..add(GetDare()),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text("Truth or Dare"),
            brightness: Brightness.dark,
          ),
          body: buildBody(context: context)),
    );
  }

  Widget buildBody({context}) =>
      BlocConsumer<TruthOrDareBloc, TruthOrDareState>(
        listener: (context, state) {
          if (state is TodError) {
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
                action: SnackBarAction(
                    label: "Try again",
                    textColor: Colors.white,
                    onPressed: () {
                      if(state.isTruth){
                      BlocProvider.of<TruthOrDareBloc>(context).add(GetTruth());
                      }else{
                        BlocProvider.of<TruthOrDareBloc>(context).add(GetDare());
                      }

                    })));
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  color: ColorBase.kPrimaryColor,
                ),
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                      top: -90,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          elevation: 2,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                state is TodLoading
                                    ? buildShimmer(context)
                                    : Text(
                                        state is DareLoaded
                                            ? "${capitalize(state.dareModel.results.level)} Dare"
                                            : state is TruthLoaded
                                                ? "${capitalize(state.truthModel.results.level)} Truth"
                                                : "",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: ColorBase.blue,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(20),
                                  child: Column(children: [
                                    state is TodLoading
                                        ? buildShimmer(context)
                                        : Text(
                                            state is DareLoaded
                                                ? state.dareModel.results.dare
                                                : state is TruthLoaded
                                                    ? state.truthModel.results
                                                        .truth
                                                    : "",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.white),
                                          ),

                                  ]),
                                ),
                                SizedBox(height: 10,),
                                Text("Dikirim oleh ${state is DareLoaded
                                    ? state.dareModel.results.user.username
                                    : state is TruthLoaded
                                    ? state.truthModel.results
                                    .user.username
                                    : ""}",style: TextStyle(fontSize: 14,color: Colors.grey),textAlign: TextAlign.end,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                buildButtonBar(context)
              ],
            ),
          ),
        ),
      );

  Shimmer buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          height: 30,
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
        ),
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100]);
  }

  Widget buildButtonBar(context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
              color: ColorBase.kPrimaryColor,
              onPressed: () {
                BlocProvider.of<TruthOrDareBloc>(context).add(GetTruth());
              },
              child: Text(
                "Truth",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: OutlineButton(
              borderSide: BorderSide(color: ColorBase.kPrimaryColor),
              onPressed: () {
                BlocProvider.of<TruthOrDareBloc>(context).add(GetDare());
              },
              child: Text(
                "Dare",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: ColorBase.kPrimaryColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
