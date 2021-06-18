import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:service_app/control/modules/user.dart';
import 'package:service_app/ui/tooles/constants/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Users_Row extends StatelessWidget {
  User user;
  Users_Row({this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        SizedBox(
          width: 280.w,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadowColor: Colors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150.w,
                  height: 150.w,
                  child: user.imageURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10000.0),
                          child: CachedNetworkImage(
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => CircleAvatar(
                              backgroundImage:
                                  AssetImage("res/images/logo.png"),
                            ),
                            imageUrl: user.imageURL,
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: AssetImage("res/images/logo.png"),
                        ),
                ),
                Text(
                  user.name,
                  style: TextStyle(
                      fontSize: Styles().fontSize_name,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                Text(
                  user.type.tr().toString(),
                  style: TextStyle(
                      fontSize: Styles().fontSize_subname,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
                SizedBox()
              ],
            ),
          ),
        ),
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.white, blurRadius: 2, spreadRadius: 2)
            ],
            color: Colors.blue,
          ),
          child: Container(
            child: IconButton(
              icon: Image(
                image: AssetImage("res/images/filtre.png"),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/user_details/${user.id}");
              },
            ),
          ),
        )
      ],
    );
  }
}
