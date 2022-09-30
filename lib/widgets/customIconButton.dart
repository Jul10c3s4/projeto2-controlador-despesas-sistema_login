import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustonIconbutton extends StatefulWidget {
  final double radius;
  final IconData icoData;
  final VoidCallback onTap;

  const CustonIconbutton
  ({super.key, required this.radius, required this.icoData, required this.onTap});

  @override
  State<CustonIconbutton> createState() => _CustonIconbuttonState();
}

class _CustonIconbuttonState extends State<CustonIconbutton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child:  Icon(widget.icoData),
        ),
      ),
    );
  }
}
