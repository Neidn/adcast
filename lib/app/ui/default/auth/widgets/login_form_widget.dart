import 'package:flutter/material.dart';

class LoginFormWidget extends StatelessWidget {
  final Widget formWidget;

  const LoginFormWidget({
    super.key,
    required this.formWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 0,
              color: Colors.black26,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: formWidget,
        ),
      ),
    );
  }
}
