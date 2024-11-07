import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../common/common.dart';
import '../router/router.dart';
import '../widgets/custom_widget.dart';
import 'fade_animationtest.dart';

class PasswordChangesPage extends StatefulWidget {
  const PasswordChangesPage({super.key});

  @override
  State<PasswordChangesPage> createState() => _PasswordChangesPageState();
}

class _PasswordChangesPageState extends State<PasswordChangesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECF4),
      body: SafeArea(
        child: Column(
          children: [
            FadeInAnimation(
              delay: 1,
              child: Text(
                "Password Changed!",
                style: Common().titelTheme,
              ),
            ),
            FadeInAnimation(
              delay: 1.5,
              child: Text(
                "Your password has been changed successfully",
                style: Common().mediumThemeblack,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FadeInAnimation(
              delay: 2,
              child: CustomElevatedButton(
                message: "Back to Login",
                function: () {
                  GoRouter.of(context).pushReplacement(Routers.loginpage.name);
                },
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
