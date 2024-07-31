import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:a2zjewelry/features/forgot_password/domain/entities/forgot_entity.dart';
import 'package:a2zjewelry/features/forgot_password/presentation/providers/forgot_provider.dart';
import 'package:a2zjewelry/features/register/presentation/widgets/loading_widget.dart';
import 'package:go_router/go_router.dart';

class ForgotPage extends ConsumerStatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends ConsumerState<ForgotPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotProvider);
    final forgotNotifier = ref.read(forgotProvider.notifier);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 30.0),
                  Image.asset(
                      'lib/assets/welcome1.png'), // Ensure this image is in your assets folder
                  SizedBox(height: 20.0),
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Enter your email to reset your password.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
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
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          final entity = ForgotEntity(
                            email: _emailController.text,
                          );
                          await forgotNotifier.forgotUser(entity, context);
                        }
                      },
                      
                      child: Text(
                        'Send Reset Link',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [InkWell(
                    onTap: () {
                      context.go('/login'); 
                    },
                    child: Text(
                      '<-- Back to Login',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),],)
                ],
              ),
            ),
          ),
          if (state.loading) LoadingWidget(),
        ],
      ),
    );
  }
}
