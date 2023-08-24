import 'package:flutter/material.dart';
import 'package:neopos/utils/app_colors.dart';

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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
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

class CommonCardMobile extends StatefulWidget {
  final String title;
  final String amount;

  const CommonCardMobile({Key? key, required this.title, required this.amount})
      : super(key: key);

  @override
  State<CommonCardMobile> createState() => _CommonCardMobileState();
}

class _CommonCardMobileState extends State<CommonCardMobile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      color: AppColors.primarySwatch.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15),
            child: Row(
              children: [
                const Icon(Icons.trending_up),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Rs.${widget.amount}",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
