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
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formKey,
                child: ListView(
                  children: [
                    //email
                    TextFormField(
                      key: const ValueKey("Email"),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text("Email address"),
                      ),
                      validator: (text) {
                        if (text == null) return "Email can't be empty!";
                        if (text.isEmpty) return "Email can't be empty!";
                        if (!text.contains('@')) return "Email is no valid!";
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
                      decoration: const InputDecoration(
                        label: Text("Password"),
                      ),
                      validator: (text) {
                        if (text == null) return "Password can't be empty!";
                        if (text.isEmpty) return "Password can't be empty!";
                        return null;
                      },
                      onSaved: (text) {
                        password = text!;
                      },
                    ),
                  ],
                ),
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => submitForm(),
                          child: Text(isLogin ? "Sign in" : "Sign up"),
                        ),
                        //trigger mode
                        TextButton(
                          onPressed: () => isLogin = !isLogin,
                          child: Text(
                            isLogin ? "Sign up" : "Sign in",
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
