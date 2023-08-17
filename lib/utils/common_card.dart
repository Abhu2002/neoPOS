import 'package:flutter/material.dart';

class CommonCard extends StatefulWidget {
  final String title;
  final String amount;
  const CommonCard({Key? key, required this.title, required this.amount})
      : super(key: key);

  @override
  State<CommonCard> createState() => _CommonCardState();
}

class _CommonCardState extends State<CommonCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Image.asset("assets/dollar_icon.png"),
                        onPressed: null),
                    Text(
                      "Rs ${widget.amount}",
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
