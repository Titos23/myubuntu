import 'package:flutter/material.dart';
import 'package:myubuntu/screens/signup_screen.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class LoginScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: FooderlichPages.loginPath,
      key: ValueKey(FooderlichPages.loginPath),
      child: const LoginScreen(),
    );
  }

  final String? username;

  const LoginScreen({
    Key? key,
    this.username,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  late final _nameC;
  late final _passC;

  @override
  void initState() {
    _nameC = TextEditingController();
    _passC = TextEditingController();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        body:  Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.all(20),),
                const Padding(padding: EdgeInsets.all(20)),
                SizedBox(
                  height: 200,
                  child: Image.asset('assets/lgw.jpg'),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Email',
                    ),
                    controller: _nameC,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    controller: _passC,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      child: const Text('Connect'),
                      onPressed: () {
                        Provider.of<AppStateManager>(context, listen: false)
                          .login(context,mail: _nameC.text, pass: _passC.text);              
                      },
                    ),
                    TextButton(
                      child: const Text('Clear'),
                      onPressed: () {
                        _nameC.clear();
                        _passC.clear();
                      },
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Center(
                  child: InkWell(
                    child: Text(
                      "No account ? Sign up !",
                      style: TextStyle(color: Colors.amber[900]),
                    ),
                    onTap: () {
                      //Provider.of<AppStateManager>(context, listen: false).signup();
                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => SignUpScreen())));
                    },
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
