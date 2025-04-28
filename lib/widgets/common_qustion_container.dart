import 'package:flutter/material.dart';

import '../utils/constant.dart';
import '../utils/common_colors.dart';

class CommonQuestionWidget extends StatefulWidget {
  final int? index;
  final String question;
  final List<dynamic>? options;
  String? selectedOption;
  final Function(String?) onOptionSelected;

  CommonQuestionWidget({
    super.key,
    required this.index,
    required this.question,
    required this.options,
    required this.onOptionSelected,
    this.selectedOption,
  });

  @override
  State<CommonQuestionWidget> createState() => _CommonQuestionWidgetState();
}

class _CommonQuestionWidgetState extends State<CommonQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    final List<int> colorList = [
      0xFF84CE2F,
      0xFFB5D92F,
      0XFFF4C741,
      0xFFF4912E,
      0xFFC81E2A,
    ];
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      margin: const EdgeInsets.only(bottom: 8.0),
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(255, 168, 166, 166), // Border color
            width: 0.5, // Border width
            style:
                BorderStyle.solid, // Border style: solid, dashed, dotted, etc.
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: kDeviceWidth / 2.5,
            child: Text(
              widget.question,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          kCommonSpaceH15,
          // kCommonSpaceH15,
          SizedBox(
              // height:50,
              // width:100,
              width: kDeviceWidth / 2.5,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                ...?widget.options?.map(
                  (option) => InkWell(
                      onTap: () {
                        String value = option.optionName ?? '';
                        var index = widget.options?.indexOf(option);
                        print('index:$index');
                        setState(() {
                          widget.selectedOption = value;
                        });
                        widget.onOptionSelected(value);
                      },
                      // height:20,
                      child: Container(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          decoration: BoxDecoration(
                              color: CommonColors.mGrey,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 5,
                                  color: widget.selectedOption ==
                                          option.optionName
                                      ? Color(colorList[
                                          widget.options?.indexOf(option) ?? 0])
                                      : CommonColors.mGrey)),
                          child: Text(' ',
                              style: TextStyle(
                                fontSize: 10,
                              )))),
                )
                /* SizedBox(
                                        // height:20,
                                        child:Container(
                                          padding:const EdgeInsets.only(left:20,),
                                          child:Text(' ',style:TextStyle(fontSize:10,)),
                                          decoration:BoxDecoration(
                                            color:Colors.red,
                                            shape:BoxShape.circle,
                                          )
                                        )
                                      ),
                                      SizedBox(
                                        // height:20,
                                        child:Container(
                                          padding:const EdgeInsets.only(left:20,),
                                          child:Text(' ',style:TextStyle(fontSize:10,)),
                                          decoration:BoxDecoration(
                                            color:Colors.red,
                                            shape:BoxShape.circle,
                                          )
                                        )
                                      ),
                                      SizedBox(
                                        // height:20,
                                        child:Container(
                                          padding:const EdgeInsets.only(left:20,),
                                          child:Text(' ',style:TextStyle(fontSize:10,)),
                                          decoration:BoxDecoration(
                                            color:Colors.red,
                                            shape:BoxShape.circle,
                                          )
                                        )
                                      ),
                                      SizedBox(
                                        // height:20,
                                        child:Container(
                                          padding:const EdgeInsets.only(left:20,),
                                          child:Text(' ',style:TextStyle(fontSize:10,)),
                                          decoration:BoxDecoration(
                                            color:Colors.red,
                                            shape:BoxShape.circle,
                                          )
                                        )
                                      ), */
              ]))
          /* kCommonSpaceV10,
          ...?widget.options?.map(
            (option) => RadioListTile<String>(
              title: Text(option.optionName ?? ''),
              value: option.optionName ?? '',
              groupValue: widget.selectedOption,
              onChanged: (String? value) {
                setState(() {
                  widget.selectedOption = value;
                });
                widget.onOptionSelected(value);
              },
            ),
          ), */
        ],
      ),
    );
  }
}
