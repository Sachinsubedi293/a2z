import 'package:a2zjewelry/features/register/domain/entities/register_entity.dart';
import 'package:a2zjewelry/features/register/presentation/providers/register_provider.dart';
import 'package:a2zjewelry/features/register/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends ConsumerStatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _allowMail = false;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerProvider);
    final registerNotifier = ref.read(registerProvider.notifier);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 60.0),
                    Image.asset(
                        'lib/assets/welcome1.png'), // Ensure this image is in your assets folder
                    SizedBox(height: 20.0),
                    Text(
                      'Get Started',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Text('by creating a free account.'),
                    SizedBox(height: 20.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Valid email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Strong Password',
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
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Confirm Password',
                            ),
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Checkbox(
                                value: _allowMail,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _allowMail = value ?? false;
                                  });
                                },
                              ),
                              Expanded(
                                child:
                                    Text('Allow to receive promotional emails'),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Checkbox(
                                value: _acceptTerms,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _acceptTerms = value ?? false;
                                  });
                                },
                              ),
                              Row(
                                children: [
                                  Text('I accept the '),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Terms and Conditions.',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  if (!_acceptTerms) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'You must accept the terms and conditions')),
                                    );
                                    return;
                                  }
                                  final entity = RegisterEntity(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    allowMail: _allowMail,
                                  );
                                  await registerNotifier.registerUser(
                                      entity, context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Text(
                                'Sign Up',
                               style: TextStyle(fontSize: 16.0)
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already a member? '),
                              InkWell(
                                onTap: () {
                                  context.go('/login');
                                },
                                child: Text(
                                  'Log In',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (state.loading) LoadingWidget(),
        ],
      ),
    );
  }
}
