import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  static const _orange = Color(0xFFFFA726);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_emailController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email and password'),
          backgroundColor: Color.fromARGB(255, 118, 88, 228),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A28C4), Color(0xFF6B44E8)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),

                // Logo
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: const BoxDecoration(
                          color: _orange,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'TripSnap',
                        style: TextStyle(
                          color: _orange,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 44),

                //  Heading
                const Text(
                  'Welcome Back, Traveler',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                const Text('👋', style: TextStyle(fontSize: 26)),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to continue your journey',
                  style: TextStyle(
                    color: Color(0xCCFFFFFF),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 36),

                // Email 
                const Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'your.email@example.com',
                    hintStyle: const TextStyle(color: Color(0x88FFFFFF), fontSize: 14),
                    filled: true,
                    fillColor: const Color(0x33FFFFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Password 
                const Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    hintStyle: const TextStyle(
                      color: Color(0x88FFFFFF),
                      fontSize: 18,
                      letterSpacing: 3,
                    ),
                    filled: true,
                    fillColor: const Color(0x33FFFFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xCCFFFFFF),
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),

                //Forgot password 
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(top: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: _orange,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                //  Login button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 3,
                      shadowColor: const Color(0x66FFA726),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // OR divider 
                Row(
                  children: const [
                    Expanded(child: Divider(color: Color(0x55FFFFFF), thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        'or',
                        style: TextStyle(color: Color(0x99FFFFFF), fontSize: 13),
                      ),
                    ),
                    Expanded(child: Divider(color: Color(0x55FFFFFF), thickness: 1)),
                  ],
                ),

                const SizedBox(height: 20),

                // // Continue with Google
                // SizedBox(
                //   width: double.infinity,
                //   height: 54,
                //   child: OutlinedButton(
                //     onPressed: () {},
                //     style: OutlinedButton.styleFrom(
                //       side: const BorderSide(color: Color(0x55FFFFFF), width: 1.2),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(14),
                //       ),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //           width: 22,
                //           height: 22,
                //           decoration: const BoxDecoration(
                //             color: Colors.white,
                //             shape: BoxShape.circle,
                //           ),
                //           alignment: Alignment.center,
                //           child: const Text(
                //             'G',
                //             style: TextStyle(
                //               color: Color(0xFF4285F4),
                //               fontSize: 13,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ),
                //         const SizedBox(width: 10),
                //         const Text(
                //           'Continue with Google',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 15,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // const SizedBox(height: 44),

                // Sign up 
                Center(
                  child: RichText(
                    text: const TextSpan(
                      text: "Don't have an account?  ",
                      style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: _orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
