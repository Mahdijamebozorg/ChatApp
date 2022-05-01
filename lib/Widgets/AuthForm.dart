import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Future<bool> Function(
    String email,
    String name,
    String password,
    bool isLogin,
    BuildContext context,
  ) submitAuthForm;
  const AuthForm(this.submitAuthForm, {Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool isLoading = false;
  bool isLogin = false;
  String email = "";
  String password = "";
  String name = "";

  final _formKey = GlobalKey<FormState>();

  Future submitForm() async {
    //return if not valid
    if (!_formKey.currentState!.validate()) return;

    //close the keyboard and save
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();

    //toggle progress indicator on
    setState(() {
      isLoading = true;
    });
    await widget
        .submitAuthForm(
      email.trim(),
      name.trim(),
      password.trim(),
      isLogin,
      context,
    )
        //toggle progress indicator off
        .then((done) {
      if (done) {
        isLoading = false;
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _screenSize.width * (kIsWeb ? 0.3 : 0.8),
          height: isLogin ? 300 : 400,
          child: Card(
            elevation: 8,
            shadowColor: Theme.of(context).primaryColor,
            child: LayoutBuilder(builder: (context, boxConstraints) {
              double _formHeight = isLogin ? 192 : 292;
              double _buttonHeight = 100;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _formHeight,
                    // width: boxConstraints.maxWidth * 0.8,
                    padding: EdgeInsets.symmetric(
                      horizontal: boxConstraints.maxWidth * 0.05,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //email
                          TextFormField(
                            key: const ValueKey("Email"),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              label: Text("Email address"),
                            ),
                            validator: (text) {
                              if (text == null) return "Email can't be empty!";
                              if (text.isEmpty) return "Email can't be empty!";
                              if (!text.contains('@')) {
                                return "Email is no valid!";
                              }
                              return null;
                            },
                            onSaved: (text) {
                              email = text!;
                            },
                          ),
                          if (!isLogin)
                            //name
                            TextFormField(
                              key: const ValueKey("name"),
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                label: Text("name"),
                              ),
                              validator: (text) {
                                if (text == null) return "name can't be empty!";
                                if (text.isEmpty) return "name can't be empty!";
                                return null;
                              },
                              onSaved: (text) {
                                name = text!;
                              },
                            ),

                          //password
                          TextFormField(
                            key: const ValueKey("Password"),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              label: Text(
                                "Password",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            validator: (text) {
                              if (text == null) {
                                return "Password can't be empty!";
                              }
                              if (text.isEmpty || text.length < 6) {
                                return "Password must be at the least 6 chars!";
                              }
                              return null;
                            },
                            onSaved: (text) {
                              password = text!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          height: _buttonHeight,
                          width: boxConstraints.maxWidth * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () => submitForm(),
                                child: Text(isLogin ? "Sign in" : "Sign up"),
                              ),
                              //trigger mode
                              TextButton(
                                onPressed: () => setState(() {
                                  (isLogin = !isLogin);
                                }),
                                child: Text(
                                  isLogin ? "Sign up" : "Sign in",
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
