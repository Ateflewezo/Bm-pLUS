import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:service_app/control/modules/user.dart';
import 'package:service_app/control/services/users.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../tooles/constants/styles.dart';

class List_operations_perm extends StatefulWidget {
  List<Permission> permissions;
  String tab_name;
  String user_id;
  List_operations_perm({this.permissions, this.tab_name, this.user_id});

  @override
  _List_operations_permState createState() => _List_operations_permState();
}

class _List_operations_permState extends State<List_operations_perm> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.permissions.length,
        itemExtent: 40,
        itemBuilder: (BuildContext context, int index) {
          Permission _permission = widget.permissions.elementAt(index);
          return Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _permission.name.tr().toString(),
                style: TextStyle(
                  fontSize: Styles().fontSize_name,
                ),
              ),
              IconButton(
                icon: _permission.value
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                      )
                    : Icon(
                        Icons.check_circle_outline,
                        color: Colors.grey,
                      ),
                onPressed: () {
                  _permission.value = !_permission.value;
                  widget.permissions[index] = _permission;
                  // widget.permissions..elementAt(index).value =
                  //     !widget.permissions.elementAt(index).value;
                  Users_provider()
                      .updateUser_Permission(widget.user_id, widget.permissions,
                          index.toString(), widget.tab_name)
                      .then((value) => setState(() {}));
                },
              )
            ],
          );
        });
  }
}
