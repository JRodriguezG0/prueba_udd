import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, {Color? backgroundColor}) {
  return AppBar(
    backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary, // Color predeterminado del tema
    title: const Text(
      'FinPlus',
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
    centerTitle: true, // Centrar el título
  );
}
