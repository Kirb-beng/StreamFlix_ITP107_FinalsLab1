import 'package:flutter/material.dart';
import '../theme/streamflix_theme.dart';
import '../theme/responsive.dart';
import '../widgets/streamflix_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreedToTerms = false;
  bool _showTermsError = false;
  int _selectedAvatar = 0;
  String? _confirmError;

  double _passwordStrengthValue = 0;
  String _passwordStrengthLabel = '';
  Color _passwordStrengthColor = StreamflixColors.grey;

  static const List<IconData> _avatarIcons = [
    Icons.person,
    Icons.face,
    Icons.sentiment_satisfied_alt,
    Icons.mood,
    Icons.emoji_emotions,
  ];

  static const List<Color> _avatarColors = [
    Color(0xFF01153E),
    Color(0xFF0071EB),
    Color(0xFF2EAD5E),
    Color(0xFFB37FEB),
    Color(0xFFF2A93B),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged(String value) {
    setState(() {
      final result = _calculateStrength(value);
      _passwordStrengthValue = result.value;
      _passwordStrengthLabel = result.label;
      _passwordStrengthColor = result.color;
      if (_confirmPasswordController.text.isNotEmpty) {
        _confirmError = _confirmPasswordController.text == value
            ? null
            : 'Passwords do not match.';
      }
    });
  }

  void _onConfirmChanged(String value) {
    setState(() {
      _confirmError = value.isEmpty
          ? null
          : (value == _passwordController.text
              ? null
              : 'Passwords do not match.');
    });
  }

  _PasswordStrength _calculateStrength(String password) {
    if (password.isEmpty) {
      return _PasswordStrength(0, '', StreamflixColors.grey);
    }
    int score = 0;
    if (password.length >= 6) score++;
    if (password.length >= 10) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;

    if (score <= 1) {
      return _PasswordStrength(0.25, 'Weak', StreamflixColors.error);
    }
    if (score <= 2) {
      return _PasswordStrength(0.5, 'Fair', const Color(0xFFF2A93B));
    }
    if (score <= 3) {
      return _PasswordStrength(0.75, 'Good', const Color(0xFFE0C93B));
    }
    return _PasswordStrength(1.0, 'Strong', const Color(0xFF2EAD5E));
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(now.year - 100),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: StreamflixColors.primary,
              onPrimary: StreamflixColors.white,
              surface: StreamflixColors.darkGrey,
              onSurface: StreamflixColors.white,
            ),
            // The navy "primary" color is too close to the dark dialog
            // background to read as button text, so force Cancel/OK
            // (and the year/month picker chevrons) to plain white.
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: StreamflixColors.white,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobController.text =
            '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  void _handleSignUp() {
    final formValid = _formKey.currentState!.validate();
    final termsOk = _agreedToTerms;
    setState(() => _showTermsError = !termsOk);

    if (formValid && termsOk) {
      // Navigator method: pushReplacementNamed, passing the entered
      // full name forward as route arguments so Home can greet the user.
      Navigator.of(context).pushReplacementNamed(
        '/home',
        arguments: _nameController.text.trim(),
      );
    }
  }

  void _goBackToLogin() {
    // Navigator method: pop — Sign-Up was pushed on top of Login,
    // so popping simply returns to the existing Login screen.
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StreamflixColors.black,
      body: StreamflixBackground(
        child: Stack(
          children: [
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
                            Text('Create Account',
                                style: StreamflixTextStyles.heading),
                            const SizedBox(height: 8),
                            Text(
                              'Just a few more steps and you\'re done.\nWe hate paperwork too.',
                              style: StreamflixTextStyles.greyBody,
                            ),
                            const SizedBox(height: 24),

                            // Full name
                            TextFormField(
                              controller: _nameController,
                              style: StreamflixTextStyles.body,
                              decoration:
                                  streamflixInputDecoration('Full name'),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your full name.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Email
                            TextFormField(
                              controller: _emailController,
                              style: StreamflixTextStyles.body,
                              keyboardType: TextInputType.emailAddress,
                              decoration: streamflixInputDecoration('Email'),
                              validator: (value) {
                                if (value == null || !value.contains('@')) {
                                  return 'Please enter a valid email.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Phone number
                            TextFormField(
                              controller: _phoneController,
                              style: StreamflixTextStyles.body,
                              keyboardType: TextInputType.phone,
                              decoration:
                                  streamflixInputDecoration('Phone number'),
                              validator: (value) {
                                if (value == null || value.trim().length < 7) {
                                  return 'Please enter a valid phone number.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Date of birth
                            TextFormField(
                              controller: _dobController,
                              readOnly: true,
                              style: StreamflixTextStyles.body,
                              onTap: _pickDate,
                              decoration:
                                  streamflixInputDecoration('Date of birth')
                                      .copyWith(
                                suffixIcon: const Icon(Icons.calendar_today,
                                    color: StreamflixColors.grey, size: 20),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your date of birth.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Avatar picker
                            Text('Choose an avatar',
                                style: StreamflixTextStyles.greyBody),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 60,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: _avatarIcons.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final selected = _selectedAvatar == index;
                                  return GestureDetector(
                                    onTap: () =>
                                        setState(() => _selectedAvatar = index),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _avatarColors[index],
                                        border: Border.all(
                                          color: selected
                                              ? StreamflixColors.white
                                              : Colors.transparent,
                                          width: 3,
                                        ),
                                      ),
                                      child: Icon(_avatarIcons[index],
                                          color: StreamflixColors.white),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Password
                            TextFormField(
                              controller: _passwordController,
                              style: StreamflixTextStyles.body,
                              obscureText: _obscurePassword,
                              onChanged: _onPasswordChanged,
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
                            if (_passwordController.text.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: _passwordStrengthValue,
                                  minHeight: 5,
                                  backgroundColor: StreamflixColors.fieldGrey,
                                  valueColor: AlwaysStoppedAnimation(
                                      _passwordStrengthColor),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _passwordStrengthLabel,
                                style: TextStyle(
                                  color: _passwordStrengthColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),

                            // Confirm password
                            TextFormField(
                              controller: _confirmPasswordController,
                              style: StreamflixTextStyles.body,
                              obscureText: _obscureConfirm,
                              onChanged: _onConfirmChanged,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: streamflixInputDecoration(
                                      'Confirm password')
                                  .copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirm
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: StreamflixColors.grey,
                                  ),
                                  onPressed: () => setState(() =>
                                      _obscureConfirm = !_obscureConfirm),
                                ),
                                // Only shows when there's no error, so it
                                // never appears at the same time as the
                                // built-in "Passwords do not match." text.
                                helperText: (_confirmError == null &&
                                        _confirmPasswordController
                                            .text.isNotEmpty)
                                    ? 'Passwords match.'
                                    : null,
                                helperStyle: const TextStyle(
                                  color: Color(0xFF2EAD5E),
                                  fontSize: 12,
                                ),
                              ),
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Terms and conditions
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: _agreedToTerms,
                                  activeColor: StreamflixColors.primary,
                                  onChanged: (value) {
                                    setState(() {
                                      _agreedToTerms = value ?? false;
                                      if (_agreedToTerms) {
                                        _showTermsError = false;
                                      }
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: RichText(
                                      text: TextSpan(
                                        style: StreamflixTextStyles.greyBody,
                                        children: [
                                          const TextSpan(text: 'I agree to the '),
                                          TextSpan(
                                            text: 'Terms and Conditions',
                                            style: StreamflixTextStyles.link,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (_showTermsError)
                              const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Text(
                                  'You must agree to the Terms and Conditions.',
                                  style: TextStyle(
                                    color: StreamflixColors.error,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 16),

                            _AnimatedPressButton(
                              label: 'Sign Up',
                              onPressed: _handleSignUp,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Text('Already have an account? ',
                                    style: StreamflixTextStyles.greyBody),
                                GestureDetector(
                                  onTap: _goBackToLogin,
                                  child: Text('Sign in now.',
                                      style: StreamflixTextStyles.link),
                                ),
                              ],
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

class _PasswordStrength {
  final double value;
  final String label;
  final Color color;
  const _PasswordStrength(this.value, this.label, this.color);
}

/// Same animated press button used on the Login screen, kept local so
/// each screen file stays self-contained and easy to grade separately.
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
