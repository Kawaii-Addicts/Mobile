import 'package:drinkify/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/theming.dart';
import '../utils/locale_support.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthController authCtrl = AuthController();
  var passwordResetEmailCtrl = TextEditingController();

  late int? selectedFieldIndex;

  @override
  void initState() {
    super.initState();
    selectedFieldIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    final transl = LocaleSupport.appTranslates(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theming.bgColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: MediaQuery.of(context).viewInsets.top + 70,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transl.logIn,
              style: const TextStyle(
                color: Theming.whiteTone,
                fontWeight: FontWeight.bold,
                fontSize: 38,
              ),
            ),
            Text(
              transl.fillFieldsBelow,
              style: TextStyle(
                color: Theming.whiteTone.withOpacity(0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _editField(
              0,
              caption: transl.email,
              icon: Icons.email_outlined,
              placeholder: transl.emailField,
              ctrl: authCtrl.emailCtrl,
            ),
            _editField(
              1,
              caption: transl.password,
              icon: Icons.lock_outline,
              placeholder: transl.passwordField,
              ctrl: authCtrl.passwordCtrl,
              isPassword: true,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                //TODO remember user's password
              },
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.5,
                          color: Theming.whiteTone.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    transl.rememberMe,
                    style: TextStyle(
                      color: Theming.whiteTone.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (authCtrl.emailCtrl.text != "" ||
                      authCtrl.passwordCtrl.text != "") {
                    authCtrl.loginUser();
                  }
                },
                child: AnimatedContainer(
                  width: double.infinity,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linearToEaseOut,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: authCtrl.emailCtrl.text == "" ||
                            authCtrl.passwordCtrl.text == ""
                        ? Theming.whiteTone.withOpacity(0.7)
                        : Theming.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    transl.logIn,
                    style: const TextStyle(
                      color: Theming.whiteTone,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => context.go("/register"),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: transl.dontHaveAnAccount,
                        style: TextStyle(
                          color: Theming.whiteTone.withOpacity(0.5),
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: " ${transl.signUp}",
                        style: const TextStyle(
                          color: Theming.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _editField(
    int index, {
    required String caption,
    required IconData icon,
    required String placeholder,
    required TextEditingController ctrl,
    bool isPassword = false,
  }) {
    const double radius = 10;
    const double iconSize = 24;

    bool isSelected = index == selectedFieldIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Stack(
        children: [
          AnimatedContainer(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut,
            decoration: BoxDecoration(
              color: Theming.bgColor,
              border: Border.all(
                width: 1.5,
                color: isSelected
                    ? Theming.primaryColor
                    : Theming.whiteTone.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: TextField(
              onTap: () {
                setState(() => selectedFieldIndex = index);
              },
              obscureText: isPassword,
              style: TextStyle(
                  color: Theming.whiteTone, letterSpacing: isPassword ? 6 : 0),
              cursorColor: Theming.primaryColor,
              controller: ctrl,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontSize: 14,
                  letterSpacing: 0,
                  color: isSelected
                      ? Theming.whiteTone.withOpacity(0.4)
                      : Colors.transparent,
                ),
                prefixIcon: Icon(
                  icon,
                  color: isSelected
                      ? Theming.primaryColor
                      : Theming.whiteTone.withOpacity(0.2),
                  size: iconSize,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          AnimatedPadding(
            padding: EdgeInsets.only(
              top: isSelected || ctrl.text.isNotEmpty ? 0 : 30,
              left: iconSize * 2,
              bottom: isSelected || ctrl.text.isNotEmpty ? 0 : 10,
            ),
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut,
            child: Container(
              color: Theming.bgColor,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                caption,
                style: TextStyle(
                  color: isSelected ? Theming.primaryColor : Theming.whiteTone,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
