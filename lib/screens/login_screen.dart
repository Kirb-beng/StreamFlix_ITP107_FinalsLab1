import 'package:flutter/material.dart';
import '../theme/streamflix_theme.dart';
import '../theme/responsive.dart';
import '../widgets/streamflix_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Navigator method #1: pushReplacementNamed
      // Replaces Login in the stack with Home so the user can't
      // press "back" and return to the login form after logging in.
      Navigator.of(context).pushReplacementNamed(
        '/home',
        arguments: _emailController.text.split('@').first,
      );
    }
  }

  void _goToSignUp() {
    // Navigator method #2: pushNamed
    // Pushes Sign-Up on top of Login, keeping Login underneath so the
    // user can pop() back to it.
    Navigator.of(context).pushNamed('/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StreamflixColors.black,
      body: StreamflixBackground(
        child: Stack(
          children: [
            // Logo pinned top-left, like the reference screenshot.
            // Font size shrinks a bit on narrow (phone-size) tabs.
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 16),
              child: StreamflixLogo(fontSize: Responsive.logoFontSize(context)),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.authHorizontalPadding(context),
                  vertical: 90,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.authCardMaxWidth(context),
                  ),
                  child: FadeSlideIn(
                    child: Form(
                      key: _formKey,
                      child: Container(
                        padding:
                            EdgeInsets.all(Responsive.authCardPadding(context)),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Login',
                                style: StreamflixTextStyles.heading),
                            const SizedBox(height: 28),
                            TextFormField(
                              controller: _emailController,
                              style: StreamflixTextStyles.body,
                              keyboardType: TextInputType.emailAddress,
                              decoration: streamflixInputDecoration(
                                  'Email or phone number'),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your email or username.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              style: StreamflixTextStyles.body,
                              obscureText: _obscurePassword,
                              decoration:
                                  streamflixInputDecoration('Password').copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: StreamflixColors.grey,
                                  ),
                                  onPressed: () => setState(() =>
                                      _obscurePassword = !_obscurePassword),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.length < 4) {
                                  return 'Password must be at least 4 characters.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            _AnimatedPressButton(
                              label: 'Login',
                              onPressed: _handleLogin,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Checkbox(
                                        value: true,
                                        onChanged: (_) {},
                                        activeColor: StreamflixColors.grey,
                                        checkColor: StreamflixColors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text('Remember me',
                                        style: StreamflixTextStyles.greyBody),
                                  ],
                                ),
                                Text('Need help?',
                                    style: StreamflixTextStyles.greyBody),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                Text('New to Streamflix? ',
                                    style: StreamflixTextStyles.greyBody),
                                GestureDetector(
                                  onTap: _goToSignUp,
                                  child: Text('Sign up now.',
                                      style: StreamflixTextStyles.link),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'This page is a school project mock-up and is '
                              'fictional app for a school project.',
                              style: TextStyle(
                                color: StreamflixColors.grey,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A red Streamflix-style button that gently scales down on press for a
/// simple, tactile animation instead of a static ElevatedButton.
class _AnimatedPressButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  const _AnimatedPressButton({required this.label, required this.onPressed});

  @override
  State<_AnimatedPressButton> createState() => _AnimatedPressButtonState();
}

class _AnimatedPressButtonState extends State<_AnimatedPressButton> {
  double _scale = 1.0;

  void _setPressed(bool pressed) {
    setState(() => _scale = pressed ? 0.97 : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: StreamflixColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: StreamflixColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
