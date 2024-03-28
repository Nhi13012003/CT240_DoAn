import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget DrawerComponent()
{
  return Drawer(
    backgroundColor: CupertinoColors.black,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
            right: Radius.circular(25)
        )
    ),
    child: Column(
      children: [
        ListTile(),

      ],
    ),
  );
}
