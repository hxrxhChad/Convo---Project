import 'package:flutter/material.dart';

void push(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void replace(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));
