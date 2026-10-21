import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../utils/ui_helpers.dart';
import 'register_screen.dart';
class LoginScreen extends StatefulWidget {
 const LoginScreen({super.key});
 @override
 State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
 final _form = GlobalKey<FormState>();
 final _email = TextEditingController();
 final _password = TextEditingController();
 bool _busy = false;
 bool _hide = true;
 Future<void> _login() async {
  if (_busy || !_form.currentState!.validate()) return;
  setState(() => _busy = true);
  try {
   final user = await AuthController().login(_email.text, _password.text);
   if (!mounted) return;
   if (user == null) { notify(context, 'Email hoặc mật khẩu không đúng'); }
   else {
    _password.clear();
    await showDialog<void>(context: context, builder: (dialogContext) => AlertDialog(
     title: const Text('Đăng nhập thành công'), content: Text('Xin chào ${user.email}'),
     actions: [TextButton(onPressed: () => Navigator.pop(dialogContext),
         child: const Text('Đóng'))],
    ));
   }
  } catch (_) { if (mounted) notify(context, 'Không thể đăng nhập. Hãy thử lại.'); }
  finally { if (mounted) setState(() => _busy = false); }
 }
 Future<void> _register() async {
  final email = await Navigator.push<String>(context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()));
  if (!mounted || email == null) return;
  _email.text = email; _password.clear();
  notify(context, 'Đăng ký thành công. Em có thể đăng nhập.');
 }
 @override
 void dispose() { _email.dispose(); _password.dispose(); super.dispose(); }
 @override
 Widget build(BuildContext context) => Scaffold(
  appBar: AppBar(title: const Text('Đăng nhập')),
  body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
   constraints: const BoxConstraints(maxWidth: 420),
   child: Card(color: Colors.grey.shade200,
       child: Padding(padding: const EdgeInsets.all(20), child: Form(key: _form, child: Column(
    mainAxisSize: MainAxisSize.min, children: [
     TextFormField(controller: _email, validator: validEmail,
         keyboardType: TextInputType.emailAddress,
         decoration: const InputDecoration(labelText: 'Email')),
     const SizedBox(height: 16),
     TextFormField(controller: _password,
         validator: (value) => value == null || value.isEmpty ? 'Nhập mật khẩu' : null,
      obscureText: _hide, decoration: InputDecoration(labelText: 'Password',
             suffixIcon: IconButton(
       onPressed: () => setState(() => _hide = !_hide),
                 tooltip: _hide ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
                 icon: Icon(_hide ? Icons.visibility_off : Icons.visibility)))),
     const SizedBox(height: 24),
     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      FilledButton(onPressed: _busy ? null : _login, child: const Text('Sign in')),
      FilledButton(onPressed: _busy ? null : _register, child: const Text('Register')),
     ]),
     if (_busy) const Padding(padding: EdgeInsets.only(top: 16),
         child: LinearProgressIndicator()),
    ],
   )))),
  ))),
 );
}
