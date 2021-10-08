import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String optionNo, correctAns, selectedOption, optionContent;
  OptionTile(
      {@required this.optionNo,
      @required this.correctAns,
      @required this.selectedOption,
      @required this.optionContent});

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          //option button
          Container(
            alignment: Alignment.center,
            width: 25.0,
            height: 25.0,
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.5),
              border: Border.all(
                  width: 1.9,
                  color: widget.optionContent == widget.selectedOption
                      ? (widget.selectedOption == widget.correctAns
                          ? Colors.green
                          : Colors.red)
                      : Colors.black54),
            ),
            child: Text(
              "${widget.optionNo}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: widget.optionContent == widget.selectedOption
                      ? (widget.selectedOption == widget.correctAns
                          ? Colors.green
                          : Colors.red)
                      : Colors.black87),
            ),
          ),
          Container(
            child: Text(
              "${widget.optionContent}",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  backgroundColor:
                      (widget.optionContent == widget.selectedOption)
                          ? ((widget.selectedOption == widget.correctAns)
                              ? Colors.green
                              : Colors.red)
                          : Colors.black87),
            ),
          )
        ],
      ),
    );
  }
}
