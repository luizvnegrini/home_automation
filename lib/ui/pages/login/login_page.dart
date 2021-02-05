import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'ilogin_presenter.dart';

class LoginPage extends StatefulWidget {
  final ILoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ILoginPresenter>('presenter', presenter));
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();

    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Builder(
          builder: (context) {
            widget.presenter.isLoadingStream.listen((isLoading) {
              if (isLoading) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    child: SimpleDialog(
                      children: [
                        Column(
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text('Aguarde...', textAlign: TextAlign.center),
                          ],
                        )
                      ],
                    ));
              } else if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            });

            widget.presenter.mainErrorStream.listen((error) {
              if (error != null) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red[900],
                  content: Text(
                    error,
                    textAlign: TextAlign.center,
                  ),
                ));
              }
            });

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoginHeader(),
                  const Headline1('login'),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                        child: Column(
                      children: [
                        StreamBuilder<String>(
                            stream: widget.presenter.emailErrorStream,
                            builder: (context, snapshot) => TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                                    icon: Icon(
                                      Icons.email,
                                      color: Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                  onChanged: widget.presenter.validateEmail,
                                  keyboardType: TextInputType.emailAddress,
                                )),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 30),
                          child: StreamBuilder<String>(
                              stream: widget.presenter.passwordErrorStream,
                              builder: (context, snapshot) => TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Senha',
                                      icon: Icon(
                                        Icons.lock,
                                        color: Theme.of(context).primaryColorLight,
                                      ),
                                      errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                                    ),
                                    onChanged: widget.presenter.validatePassword,
                                    obscureText: true,
                                  )),
                        ),
                        StreamBuilder<bool>(
                            stream: widget.presenter.isFormValidStream,
                            builder: (context, snapshot) => RaisedButton(
                                  onPressed: snapshot.data == true ? widget.presenter.auth : null,
                                  textColor: Colors.white,
                                  child: Text('Entrar'.toUpperCase()),
                                )),
                        FlatButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.person),
                          label: const Text('Criar conta'),
                        )
                      ],
                    )),
                  )
                ],
              ),
            );
          },
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ILoginPresenter>('presenter', widget.presenter));
  }
}
