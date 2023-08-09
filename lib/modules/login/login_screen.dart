import 'package:flutter/material.dart';
import 'package:section3/modules/masager/masanger_screen.dart';
import 'package:section3/shared/componant/component.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassword=true;

  var emailController=TextEditingController();

  var passController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultTextForm(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    labelText: 'Email',
                    // validate:(String value){
                    //   if(value.isEmpty){
                    //     return 'jvkhkjbjk';
                    //   }
                    //   return null;
                    // },
                    validate: (value){
                      if(value.isEmpty){
                        return 'the email not allow to be empty';
                      }
                      return null;
                    },
                    prefix: Icons.email,

                  ),
                  SizedBox(
                    height: 15.5,
                  ),
                  defaultTextForm(
                    controller: passController,
                    type: TextInputType.visiblePassword,
                    labelText: 'Password',
                      validate: (value){
                        if(value.isEmpty){
                          return 'the password not allow to be empty';
                        }
                        return null;
                      },
                    prefix: Icons.lock,
                    suffix:isPassword? Icons.visibility : Icons.visibility_off,
                    isPassword: isPassword,
                    suffixPressed: (){
                      setState(() {
                        isPassword= !isPassword;
                      });
                    }
                      ),
                  SizedBox(
                    height:20.5,
                  ),
                  defaultButton(
                      background:Colors.purpleAccent,
                      isUpperCase: false,
                      text:'Login',
                      function: () {
                          if(formKey.currentState!.validate()) {
                            print(emailController.text);
                            print(passController.text);
                          }
                  }
                  ),

                  SizedBox(
                    height:12.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?'
                      ),
                      TextButton(onPressed: (){}, child: Text('Register Now'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 
