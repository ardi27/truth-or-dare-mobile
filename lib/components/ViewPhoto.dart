
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:truthordare/constants/Colors.dart';

class ViewFoto extends StatefulWidget {
  final String foto;

  const ViewFoto({Key key, this.foto}) : super(key: key);
  @override
  _ViewFotoState createState() => _ViewFotoState();
}

class _ViewFotoState extends State<ViewFoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.clear),
          color: Colors.white,
          onPressed: ()=> Navigator.pop(context),),
      ),
      body: Container(
        child: widget.foto==null?Center(child: Icon(Icons.person,size: 200,color: ColorBase.kPrimaryColor,),):PhotoView(
          imageProvider: NetworkImage(widget.foto),
        ),
      ),
    );
  }
}