import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truthordare/blocs/truth_or_dare/authentication/auth_bloc.dart';
import 'package:truthordare/blocs/truth_or_dare/profile/profile_bloc.dart';
import 'package:truthordare/constants/Strings.dart';
import 'package:truthordare/constants/route_paths.dart';
import 'package:truthordare/service_locator.dart';
import 'package:truthordare/utilities/firebase_storage_helper.dart';
import 'package:truthordare/utilities/image_picker_helper.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(AppStarted()),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => sl<ProfileBloc>()..add(LoadProfile()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text("Profile"),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthUnauthenticated) {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, homeRoute);
                  Navigator.pushNamed(context, loginRoute);
                }
              },
            ),
          ],
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProfileLoaded) {
                return BuildProfileBody(state: state,);
              }else if (State is ProfileFailure){
                return Center(child: Text("Terjadi kesalahan internet"),);
              }
              return Center(child: Text("Terjadi kesalahan internet"),);
            },
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }


}

class BuildProfileBody extends StatefulWidget {
  final ProfileLoaded state;
  const BuildProfileBody({
    Key key, this.state,
  }) : super(key: key);

  @override
  _BuildProfileBodyState createState() => _BuildProfileBodyState();
}

class _BuildProfileBodyState extends State<BuildProfileBody> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: InkWell(
                onTap: () async {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10))
                    ),
                    context: context,
                    builder:(_)=> Wrap(
                      children: [
                        ListTile(
                          title: Text("Lihat foto"),
                          leading: Icon(Icons.remove_red_eye_rounded),
                          onTap: (){
                            Navigator.pushNamed(context, viewPhotoRoute,arguments: widget.state.user.results.profilePhotoUrl.toString());
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Ubah foto"),
                          leading: Icon(Icons.camera_alt),
                          onTap: () async {
                            String path = await ImagePickerHelper.getImage(
                                source: ImageSource.gallery);
                            String url = await FirebaseStorageHelper.uploadToStorage(
                                path: path,
                                key: "${Strings.avatarPath}/${widget.state.user.results.uuid}.png");
                            BlocProvider.of<ProfileBloc>(context).add(UpdateProfile(data:{"profile_photo_url":url}));
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  );

                },
                child:widget.state.user.results.profilePhotoUrl==null?CircleAvatar(
                    child:Icon(Icons.person)
                ):Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              widget.state.user.results.profilePhotoUrl.toString()))),
                ),
              ),
              title: Text(widget.state.user.results.username),
              subtitle: Text(widget.state.user.results.email),
              trailing: InkWell(
                onTap: () {},
                child: Icon(Icons.edit_outlined),
              ),
            ),
            ListTile(
              leading: Icon(Icons.question_answer_outlined),
              title: Text("Submitted Truth"),
              onTap: () {
                Navigator.pushNamed(context, userTodRoute,arguments: 0);
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_run),
              title: Text("Submitted Dare"),
              onTap: () {
                Navigator.pushNamed(context, userTodRoute,arguments: 1);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(UserLoggedOut());
                Navigator.pushNamedAndRemoveUntil(
                    context, homeRoute, (route) => route.isCurrent);
              },
            ),
          ],
        ),
      ),
    );
  }
}
