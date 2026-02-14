import 'package:flutter/material.dart';
import 'package:valentine_app/widgets/app_snackbar.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';

class VerificationScreen extends StatefulWidget {
  final VoidCallback onSuccess;

  const VerificationScreen({
    super.key,
    required this.onSuccess,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  String? nameError;
  String? passwordError;
  String? relationshipStatus;

  @override
  void initState() {
    super.initState();

    nameFocusNode.addListener(() {
      if (!nameFocusNode.hasFocus) {
        validateName();
      }
    });

    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        validatePassword();
      }
    });

    nameController.addListener(() {
      setState(() {});
    });

    passwordController.addListener(() {
      setState(() {});
    });
  }

  void validateName() {
    setState(() {
      if (nameController.text.trim() != 'Michał') {
        nameError = 'Nie jesteś moim chłopem - spadaj';
      } else {
        nameError = null;
      }
    });
  }

  void validatePassword() {
    setState(() {
      if (passwordController.text.trim() != 'dog') {
        passwordError = '3 litery - 🐶';
      } else {
        passwordError = null;
      }
    });
  }

  void tryContinue() {
    validateName();
    validatePassword();

    if (nameError != null || passwordError != null) {
      return;
    }

    if (relationshipStatus != 'taken') {
      return;
    }

    widget.onSuccess();
  }

  bool get isFormValid {
    return nameController.text.trim() == 'Michał' &&
           passwordController.text.trim() == 'dog' &&
           relationshipStatus == 'taken';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Formularz walentynkowy 💗',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sprawdźmy, czy to na pewno Ty',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 64),

                  AppTextField(
                    controller: nameController,
                    label: 'Twoje imię',
                    errorText: nameError,
                    focusNode: nameFocusNode,
                  ),
                  const SizedBox(height: 18),

                  AppTextField(
                    controller: passwordController,
                    label: 'Hasło',
                    obscureText: true,
                    errorText: passwordError,
                    focusNode: passwordFocusNode,
                  ),

                  const SizedBox(height: 32),

                  Text(
                    'Status związku',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),

                  _radioSingle(),
                  _radioComplicated(),
                  _radioTaken(),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: PrimaryButton(
              text: 'Dalej',
              onPressed: tryContinue,
              enabled: isFormValid,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _radioSingle() {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: RadioListTile<String>(
        title: const Text('Wolny'),
        value: 'single',
        activeColor: Theme.of(context).primaryColor,
        splashRadius: 0,
        groupValue: relationshipStatus,
        onChanged: (_) {
          setState(() {
            relationshipStatus = null;
          });
          showAppSnackBar(
            context,
            message: 'Error 404: girlfriend not found. Try again.',
            imageAsset: 'assets/images/iks.png',
          );
        },
      ),
    );
  }

  Widget _radioComplicated() {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: RadioListTile<String>(
        title: const Text('To skomplikowane'),
        value: 'complicated',
        activeColor: Theme.of(context).primaryColor,
        splashRadius: 0,
        groupValue: relationshipStatus,
        onChanged: (_) {
          setState(() {
            relationshipStatus = null;
          });
          showAppSnackBar(
            context,
            message: 'Chyba coś Ci się pomyliło...',
            imageAsset: 'assets/images/heart.png',
          );
        },
      ),
    );
  }

  Widget _radioTaken() {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: RadioListTile<String>(
        title: const Text('Zajęty'),
        value: 'taken',
        activeColor: Theme.of(context).primaryColor,
        splashRadius: 0,
        groupValue: relationshipStatus,
        onChanged: (value) {
          setState(() {
            relationshipStatus = value;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    nameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
