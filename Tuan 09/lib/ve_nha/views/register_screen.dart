import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../utils/ui_helpers.dart';
class RegisterScreen extends StatefulWidget {
 const RegisterScreen({super.key});
 @override
 State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
 final _form = GlobalKey<FormState>();
 final _email = TextEditingController();
 final _password = TextEditingController();
 final _confirm = TextEditingController();
 bool _busy = false;
 Future<void> _save() async {
  if (_busy || !_form.currentState!.validate()) return;
  setState(() => _busy = true);
  try {
   await AuthController().register(_email.text, _password.text);
   if (mounted) Navigator.pop(context, _email.text.trim().toLowerCase());
  } on AuthException catch (e) { if (mounted) notify(context, e.message); }
  catch (_) { if (mounted) notify(context, 'Không thể đăng ký. Hãy thử lại.'); }
  finally { if (mounted) setState(() => _busy = false); }
 }
 @override
 void dispose() { _email.dispose(); _password.dispose(); _confirm.dispose(); super.dispose(); }
 @override
 Widget build(BuildContext context) => Scaffold(
  appBar: AppBar(title: const Text('Register')),
  body: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Form(key: _form,
      child: Column(children: [
   TextFormField(controller: _email, validator: validEmail,
       keyboardType: TextInputType.emailAddress,
       decoration: const InputDecoration(labelText: 'Email')),
   const SizedBox(height: 16),
   TextFormField(controller: _password, obscureText: true,
    validator: (value) => value == null || value.trim().length < 6 ?
    'Mật khẩu tối thiểu 6 ký tự, không chỉ chứa khoảng trắng' : null,
    decoration: const InputDecoration(labelText: 'Password')),
   const SizedBox(height: 16),
   TextFormField(controller: _confirm, obscureText: true,
    validator: (value) => value != _password.text ? 'Mật khẩu xác nhận không khớp' : null,
    decoration: const InputDecoration(labelText: 'Xác nhận mật khẩu')),
   const SizedBox(height: 24),
   Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    TextButton(onPressed: _busy ? null : () => Navigator.pop(context), child: const Text('Hủy')),
    FilledButton(onPressed: _busy ? null : _save,
        child: Text(_busy ? 'Đang đăng ký...' : 'Đăng ký')),
   ]),
  ]))),
 );
}
