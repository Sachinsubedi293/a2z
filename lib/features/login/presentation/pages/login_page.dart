import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:a2zjewelry/features/login/domain/entities/login_entity.dart';
import 'package:a2zjewelry/features/login/presentation/providers/login_provider.dart';
import 'package:a2zjewelry/features/register/presentation/widgets/loading_widget.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 30,),
                      Image.asset('lib/assets/welcome1.png'),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Welcome back',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      const Text('Sign in to access your account'),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Enter your email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          InkWell(
                            onTap: () {
                            context.go('/forgot');
                            },
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final entity = LoginEntity(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              await loginNotifier.loginUser(entity, context);
                            }
                          },
                          child: const Text('Log In', style: TextStyle(fontSize: 16.0)),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('New Here? '),
                          InkWell(
                            onTap: () {
                             context.go('/register');
                            },
                            child: const Text(
                              'Register now',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(children: <Widget>[
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "OR",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          ElevatedButton.icon(
                            
                            onPressed: () {
                              // Add your Google sign-in logic here
                            },
                            icon: Image.asset(
                              'lib/assets/google.png',
                              height: 24.0,
                              width: 24.0,
                            ),
                            label: const Text('Sign in with Google'),
                            style: ElevatedButton.styleFrom(
                              
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 15),
                              textStyle: const TextStyle(fontSize: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                           ElevatedButton.icon(
                            
                            onPressed: () {
                              // Add your facebook sign-in logic here
                            },
                            icon: Image.asset(
                              'lib/assets/facebook.png',
                              height: 24.0,
                              width: 24.0,
                            ),
                            label: const Text('Sign in with Facebook'),
                            style: ElevatedButton.styleFrom(
                              
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 15),
                              textStyle: const TextStyle(fontSize: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (state.loading)
              Positioned.fill(
                child: Container(
                  color: Colors.black54,
                  child: const Center(child: LoadingWidget()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
