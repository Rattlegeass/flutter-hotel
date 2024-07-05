import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tester/utils/config.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppbar(
      {super.key, this.appTitle, this.route, this.icon, this.actions});
  @override
  Size get preferredSize =>
      const Size.fromHeight(60); //default height of appbar

  final String? appTitle;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white, //background color is white in this app
      elevation: 0,
      centerTitle: true,
      title: Text(
        widget.appTitle!,
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
      leading: widget.icon != null
          ? Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Config.primaryColor),
              child: IconButton(
                onPressed: () {
                  if (widget.route != null) {
                    // if route given, then this icon button will navigate to that route
                    Navigator.of(context).pushNamed(widget.route!);
                  } else {
                    // else, just simply pop back to previous page
                    Navigator.of(context).pop();
                  }
                },
                icon: widget.icon!,
                color: Colors.white,
              ),
            )
          : null,
      actions: widget.actions ?? null,
    );
  }
}
