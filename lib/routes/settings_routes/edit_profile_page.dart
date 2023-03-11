import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/widgets/custom_floating_button.dart';

import '/utils/theming.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var usernameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var firstNameCtrl = TextEditingController();
  var lastNameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theming.bgColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      floatingActionButton: CustomFloatingButton(
        backgroundColor: Theming.primaryColor,
        onTap: () {},
        child: const Text(
          "Zapisz",
          style: TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theming.bgColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Theming.whiteTone,
            ),
          ),
        ),
        title: const Text(
          "Edytuj profil",
          style: TextStyle(
            color: Theming.whiteTone,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Theming.bgColorLight,
                    backgroundImage: NetworkImage(
                      "https://imgs.search.brave.com/Sh1KvzTzy10m30RShyompgGbNefsark8-QTMfC19svY/rs:fit:370:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC54/MWpmLWJTdGJlbkFo/U0poYXdKMmNRSGFK/ZSZwaWQ9QXBp",
                    ),
                  ),
                  _editField(
                    0,
                    caption: "Nazwa użytkownika",
                    placeholder: "Podaj nazwę użytkownika",
                    ctrl: usernameCtrl,
                    isUsername: true,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _editField(
                1,
                caption: "E-mail",
                placeholder: "Podaj e-mail",
                ctrl: emailCtrl,
              ),
              _editField(
                2,
                caption: "Imię",
                placeholder: "Podaj imię",
                ctrl: firstNameCtrl,
              ),
              _editField(
                3,
                caption: "Nazwisko",
                placeholder: "Podaj nazwisko",
                ctrl: lastNameCtrl,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    enableDrag: false,
                    backgroundColor: Theming.bgColor,
                    builder: (ctx) {
                      var oldPasswordCtrl = TextEditingController();
                      var newPasswordNameCtrl = TextEditingController();
                      return SizedBox(
                        height: 110 * 2 + 200,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 30,
                          ),
                          child: Column(
                            children: [
                              _editField(
                                4,
                                caption: "Stare hasło",
                                placeholder: "Podaj stare hasło",
                                ctrl: oldPasswordCtrl,
                              ),
                              _editField(
                                5,
                                caption: "Nowe haslo",
                                placeholder: "Podaj nowe hasło",
                                ctrl: newPasswordNameCtrl,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theming.primaryColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Text(
                                    "Zmień hasło",
                                    style: TextStyle(
                                      color: Theming.whiteTone,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0x9F000E1F),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    "Zmień hasło",
                    style: TextStyle(
                      color: Theming.whiteTone,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 300),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editField(
    int index, {
    required String caption,
    required String placeholder,
    required TextEditingController ctrl,
    bool isPassword = false,
    bool isUsername = false,
  }) {
    const double radius = 20;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: radius / 2),
            Text(
              caption,
              style: const TextStyle(
                color: Theming.whiteTone,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Container(
          height: 60,
          width: isUsername
              ? (MediaQuery.of(context).size.width - 30 * 2) / 1.6
              : double.infinity,
          margin: const EdgeInsets.only(bottom: 30),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: const Color(0xFF000E1F),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: TextField(
            obscureText: isPassword,
            style: const TextStyle(color: Theming.whiteTone),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(
                color: Theming.whiteTone.withOpacity(0.4),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
