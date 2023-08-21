// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modern_ui/components/my_buton.dart';
import 'package:modern_ui/components/my_textfields.dart';
import 'package:modern_ui/components/square_tile.dart';

class LoginPage extends StatefulWidget {
   final Function()? onTap;
   LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  

  //Text editing controllers 
final emailController = TextEditingController();
final passwordController = TextEditingController();

//Sign user in 
void signUserIn() async {
  //show loading circle 
  showDialog(
     context: context,
       builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
        );
       },
    );

  // error message
  void showErrorMessage(String message){
    showDialog(
      context: context, 
      builder: (context) {
     return  AlertDialog(
      title: Center(
        child: Text(
          message,
          style: TextStyle(color: Color.fromARGB(255, 12, 12, 12)),
        ),
      )
      );
    });
  }
 
 
 

  //try sign in 
  try {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
   email: emailController.text,
   password: passwordController.text,   
   );

  //pop loading circle 
   Navigator.pop(context);
  


  } on FirebaseAuthException catch (e) {
      //Pop loading circle
      Navigator.pop(context);
      //Show error message
      showErrorMessage(e.code);
          
  } 


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
              //Logo 
              // ignore: prefer_const_constructors
              Icon(
                Icons.lock,
                size: 100,
                ),
                
              SizedBox(height: 50),
                            
              //welcome back,You've been missed 
              Text(
                'Welcome back , You\'ve been missed!',
                style: TextStyle(
                  color: Color.fromARGB(255, 73, 72, 72),
                  fontSize: 16,
          
                ),
                ),
          
              SizedBox(height: 25),
                             
              //username textfield 
                
              MyTextField(
                controller: emailController,
                hintText: 'Username',
                obscureText: false,
          
              ),   
                
              SizedBox(height: 10),   
              //password textfield 
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
          
              ),
              SizedBox(height: 10),   
              //forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Paasswod',
                       style: TextStyle(
                        color: Colors.grey[700],
                        ),
                      ),
                  ],
                ),
              ),
               SizedBox(height: 25), 
                
              //sign in botton
              MyButton(
                text: 'Sign In',
                onTap:signUserIn,
              ),
              SizedBox(height: 50), 
              //or continue with 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:25.0),
              child: Row(
                children: [
                Expanded(
                  child:Divider(
                        thickness: 0.9,
                        color: Colors.grey[400],
                     )
                  ),
               Text(
                'Or continue with',
               style: TextStyle(color: Colors.grey[700]),
               ),
                   Expanded(
                  child: Divider(
                     thickness: 0.9,
                     color: Colors.grey[400],
                  )
               ),
              ],),
            ), 
              SizedBox(height: 40),                 
              //google + sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                //google logo
                SquareTile(imagePath:'/Users/phamkate/Documents/modern_ui/lib/images/googlelogo.jpeg' ),
                const SizedBox(width:25),
                                
                //apple logo
                SquareTile(imagePath:'/Users/phamkate/Documents/modern_ui/lib/images/applelogo.jpeg')
          
              ],
              ),
                
              SizedBox(height: 20),  
              //not a member / register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
          
                Text('Not a member '),
                const SizedBox(width: 4),
          
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text('Register now ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 1, 29, 141),
                    fontWeight: FontWeight.bold
                    )),
                )
          
          
              ],)                                            
                
                
            ],),
          ),
        ),
      ),




    );
  }
}