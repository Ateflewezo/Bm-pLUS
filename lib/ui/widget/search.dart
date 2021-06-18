import 'package:flutter/material.dart';
import 'package:rounded_floating_app_bar/rounded_floating_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: NestedScrollView(
          headerSliverBuilder: (context, isInnerBoxScroll) {
            return [
              RoundedFloatingAppBar(
                floating: true,
                snap: true,
                title: TextField(
                  decoration: InputDecoration(
                    focusColor: Colors.red,
                    fillColor: Color(0XFFFBFBFB),
                    hintStyle:
                        TextStyle(color: Color(0XFF808080), fontSize: 14),
                    hintText: "shearch_txt".tr().toString(),
                    alignLabelWithHint: true,
                    suffixIcon: IconButton(
                        icon: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            child: Icon(Icons.close)),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ];
          },
          body: Container(),
        ),
      ),
    );
  }
}
