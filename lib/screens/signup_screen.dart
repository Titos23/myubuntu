import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class SignUpScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: FooderlichPages.loginPath,
      key: ValueKey(FooderlichPages.signupPath),
      child: const SignUpScreen(),
    );
  }

  

  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  late final _emailC;
  late final _passC;
  late final _nameC;

  @override
  void initState() {
    _nameC = TextEditingController();
    _passC = TextEditingController();
    _emailC = TextEditingController();
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
        appBar:AppBar(
          title: Center(child: Text("Creating account")),
        ),
        body:  Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.all(20)),
                SizedBox(
                  height: 200,
                  child: Image.asset('assets/lgw.jpg'),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'What is your name ?'
                  ),
                  controller: _nameC,
                ),
                const Padding(padding: EdgeInsets.all(20)),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email adress'
                  ),
                  controller: _emailC,
                ),
                const Padding(padding: EdgeInsets.all(20)),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                  ),
                  obscureText: true,
                  controller: _passC,
                ),
                const Padding(padding: EdgeInsets.all(20)),
                ButtonBar(
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          Provider.of<AppStateManager>(context, listen: false)
                            .create(context,mail: _emailC.text, pass: _passC.text); 
                          Provider.of<AppStateManager>(context, listen: false).username = _nameC.text; 
                          Provider.of<AppStateManager>(context, listen: false).signupout();   
                              
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
