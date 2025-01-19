import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';

final emailProvider = StateProvider<String>((ref) => "");
final passwordProvider = StateProvider<String>((ref) => "");
final fullNameProvider = StateProvider<String>((ref) => "");
final loadingProvider = StateProvider<bool>((ref) => false);
final agreedToTermsProvider = StateProvider<bool>((ref) => false);
final isPasswordVisibleProvider = StateProvider<bool>((ref) => false);
final isConfirmPasswordVisibleProvider = StateProvider<bool>((ref) => false);

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  Future<void> signUp(WidgetRef ref) async {
    final email = ref.read(emailProvider);
    final password = ref.read(passwordProvider);
    final fullName = ref.read(fullNameProvider);
    final agreedToTerms = ref.read(agreedToTermsProvider);

    if (!agreedToTerms) {
      ScaffoldMessenger.of(ref.context).showSnackBar(
        const SnackBar(content: Text('You must agree to the terms and conditions')),
      );
      return;
    }

    ref.read(loadingProvider.notifier).state = true;

    const String url = 'https://iitj-devquest.onrender.com/api/v1/users/register';
    final body = {
      "email": email,
      "password": password,
      "fullName": fullName,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = jsonDecode(response.body)["message"];
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        Navigator.push(
          ref.context,
          MaterialPageRoute(builder: (context) =>  LoginScreen()),
        );
      }  else {
        final error = jsonDecode(response.body);
        final errorMessage = error["error"] ?? "Signup failed!";
        print(errorMessage);
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(ref.context).showSnackBar(
        SnackBar(content: Text("Error: $e.")),
      );
    } finally {
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
    final isPasswordVisible = ref.watch(isPasswordVisibleProvider);
    final isConfirmPasswordVisible = ref.watch(isConfirmPasswordVisibleProvider);
    final agreedToTerms = ref.watch(agreedToTermsProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade900,
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Let's Get Started!",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Priotritize your health first. Sign up now!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[300],
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Input your full name',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(Icons.person_outline, color: Colors.grey[400]),
                          ),
                          onChanged: (value) => ref.read(fullNameProvider.notifier).state = value,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Input your email',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[400]),
                          ),
                          onChanged: (value) => ref.read(emailProvider.notifier).state = value,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          obscureText: !isPasswordVisible,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey[400],
                              ),
                              onPressed: () => ref.read(isPasswordVisibleProvider.notifier).state =
                              !isPasswordVisible,
                            ),
                          ),
                          onChanged: (value) => ref.read(passwordProvider.notifier).state = value,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: agreedToTerms,
                              onChanged: (value) =>
                              ref.read(agreedToTermsProvider.notifier).state = value ?? false,
                              fillColor: MaterialStateProperty.resolveWith<Color>(
                                    (states) => states.contains(MaterialState.selected)
                                    ? Colors.green
                                    : Colors.grey.withOpacity(0.2),
                              ),
                            ),
                            Text(
                              'I agree to the terms and conditions',
                              style: TextStyle(color: Colors.grey[300]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : () => signUp(ref),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isLoading
                                ? CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                                : const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(color: Colors.grey[300]),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  ref.context,
                                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                                );
                              },

                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
