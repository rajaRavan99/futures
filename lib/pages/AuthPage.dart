import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:future/pages/Logins/SignUp.dart';

import 'Logins/SignIn.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin ? const SignIn() : SignUp();

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
