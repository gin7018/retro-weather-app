import 'package:flutter/material.dart';
import 'package:weather_app_ui/misc/styles.dart';

class SmallInfoCard extends StatefulWidget {
  const SmallInfoCard(
      {super.key,
      required this.cardDeco,
      required this.cardTitle,
      required this.cardBody,
      this.description});

  final ColorThemeSetter cardDeco;
  final String cardTitle;
  final String cardBody;
  final String? description;

  @override
  State<SmallInfoCard> createState() => _SmallInfoCardState();
}

class _SmallInfoCardState extends State<SmallInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: widget.cardDeco.containerDeco,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.cardTitle),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: widget.cardDeco.boxColor,
            child: Column(
              children: [
                Text(
                  widget.cardBody,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
                Text(widget.description ?? "")
              ],
            ),
          )
        ],
      ),
    );
  }
}
