import 'package:MovieProject/widget/comic/list_image.dart';
import 'package:flutter/material.dart';

class ListComicScreen extends StatefulWidget {
  final dynamic arguments;
  final String position;
  final String id;
  const ListComicScreen({Key key, this.arguments, this.position, this.id}) : super(key: key);
  @override
  _ListComicScreenState createState() => _ListComicScreenState();
}

class _ListComicScreenState extends State<ListComicScreen> {
  @override
  Widget build(BuildContext context) {
    return ListImage(arguments: widget.arguments,position: widget.position,id: widget.id,);
  }
}