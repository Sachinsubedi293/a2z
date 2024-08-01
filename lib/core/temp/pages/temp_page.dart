import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('lib/assets/welcome1.png'),
                const SizedBox(height: 20.0),
                const Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                const Text('Enter your email to reset your password.'),
                const SizedBox(height: 20.0),
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle password reset logic
                    },
                    child: const Text('Send Reset Link',style: TextStyle(fontSize: 16.0),),
                  ),
                ),
                const SizedBox(height: 20.0),
                InkWell(
                  onTap: () {
                    Navigator.pop(context); 
                  },
                  child: const Text(
                    '<-- Back to Login',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
