import 'package:flutter/material.dart';

class StatsInput extends StatelessWidget {
  String text;
  StatsInput({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900),
          ),
          Container(
            height: 70,
            decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200, width: 10)),
            child: TextField(),
          )
        ],
      ),
    );
  }
}
