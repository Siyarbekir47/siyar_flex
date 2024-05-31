import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final int id;
  const Details({super.key, required this.id});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Center(
        child: Text('Details for movie with ID ${widget.id}'),
      ),
    );
  }
}
