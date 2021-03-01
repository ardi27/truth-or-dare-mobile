import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/truth_or_dare_bloc.dart';
import 'package:truthordare/constants/Lists.dart';
import 'package:truthordare/service_locator.dart';
import 'package:truthordare/constants/Colors.dart';
import 'package:truthordare/constants/Dictionary.dart';
import 'package:truthordare/utilities/SharedPreferences.dart';
import 'package:truthordare/utilities/string_helper.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedLevel;

  Future setSelectedLevel() async {
    selectedLevel = await Preferences.getDataInt("level") ?? -1;
  }

  @override
  void initState() {
    super.initState();
    setSelectedLevel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TruthOrDareBloc>(
      create: (context) => sl<TruthOrDareBloc>()..add(GetTruth(selectedLevel: selectedLevel??-1)),
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
                      child: Text(
                        state.errMessage.split(Dictionary.exeption).last,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                action: SnackBarAction(
                    label: "Try again",
                    textColor: Colors.white,
                    onPressed: () {
                      if (state.isTruth) {
                        BlocProvider.of<TruthOrDareBloc>(context)
                            .add(GetTruth(selectedLevel: selectedLevel));
                      } else {
                        BlocProvider.of<TruthOrDareBloc>(context)
                            .add(GetDare(selectedLevel: selectedLevel));
                      }
                    })));
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      color: ColorBase.kPrimaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:100),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 2,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              (state is TruthLoaded &&
                                  state.truthModel.results == null) ||
                                  (state is DareLoaded &&
                                      state.dareModel.results == null)
                                  ? Column(
                                children: [
                                  Icon(
                                    Icons.dangerous,
                                    size: 50,
                                    color: ColorBase.kPrimaryColor,
                                  ),
                                  Text(
                                    "Tidak ada Truth or Dare untuk level yang dipilih",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                                  : Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
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
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorBase.blue,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    width: MediaQuery.of(context)
                                        .size
                                        .width,
                                    padding: EdgeInsets.all(20),
                                    child: Column(children: [
                                      state is TodLoading
                                          ? buildShimmer(context)
                                          : Text(
                                        state is DareLoaded
                                            ? state.dareModel
                                            .results.dare
                                            : state
                                        is TruthLoaded
                                            ? state
                                            .truthModel
                                            .results
                                            .truth
                                            : "",
                                        style: TextStyle(
                                            fontSize: 24,
                                            color:
                                            Colors.white),
                                      ),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Dikirim oleh ${state is DareLoaded ? state.dareModel.results.user.username : state is TruthLoaded ? state.truthModel.results.user.username : ""}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 10,
                                  children: level.map((e) {
                                    return ChoiceChip(
                                      label: Text(capitalize(e)),
                                      selected: level.indexOf(e) ==
                                          selectedLevel,
                                      onSelected: (value) async {
                                        print("Oke");
                                        if (state is TruthLoaded) {
                                          if (selectedLevel ==
                                              level.indexOf(e)) {
                                            BlocProvider.of<
                                                TruthOrDareBloc>(
                                                context)
                                                .add(GetTruth(
                                                selectedLevel: -1));
                                            selectedLevel = -1;
                                          } else {
                                            BlocProvider.of<
                                                TruthOrDareBloc>(
                                                context)
                                                .add(GetTruth(
                                                selectedLevel: level
                                                    .indexOf(e)));
                                            selectedLevel =
                                                level.indexOf(e);
                                            print("Here");
                                          }
                                        } else if (state
                                        is DareLoaded) {
                                          if (selectedLevel ==
                                              level.indexOf(e)) {
                                            BlocProvider.of<
                                                TruthOrDareBloc>(
                                                context)
                                                .add(GetDare(
                                                selectedLevel: -1));
                                            selectedLevel = -1;
                                          } else {
                                            BlocProvider.of<
                                                TruthOrDareBloc>(
                                                context)
                                                .add(GetDare(
                                                selectedLevel: level
                                                    .indexOf(e)));
                                            selectedLevel =
                                                level.indexOf(e);
                                          }
                                          setState(() {});
                                        }
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                              buildButtonBar(context, state)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),

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

  Widget buildButtonBar(context, state) {
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
                BlocProvider.of<TruthOrDareBloc>(context).add(GetTruth(
                    selectedLevel:
                        selectedLevel));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state is TruthLoaded
                      ? Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      : SizedBox(),
                  Text(
                    "Truth",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
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
                BlocProvider.of<TruthOrDareBloc>(context).add(GetDare(
                    selectedLevel:
                        selectedLevel));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state is DareLoaded
                      ? Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: ColorBase.kPrimaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      : SizedBox(),
                  Text(
                    "Dare",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ColorBase.kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
