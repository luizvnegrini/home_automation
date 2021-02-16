import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/components/components.dart';
import '../../../ui/helpers/i18n/resources.dart';
import '../../../ui/pages/signup/signup.dart';

class SignUpPage extends StatelessWidget {
  final ISignUpPresenter presenter;

  const SignUpPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    void _hideKeyboard() {
      final currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
    }

    return Scaffold(
      body: Builder(
          builder: (context) => GestureDetector(
                onTap: _hideKeyboard,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Headline1(R.string.signUp),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Provider(
                          create: (_) => presenter,
                          child: Form(
                              child: Column(
                            children: [
                              NameInput(),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: EmailInput(),
                              ),
                              PasswordInput(),
                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 32),
                                child: PasswordConfirmationInput(),
                              ),
                              SignUpButton(),
                              FlatButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.login),
                                label: Text(R.string.login),
                              )
                            ],
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ISignUpPresenter>('presenter', presenter));
  }
}