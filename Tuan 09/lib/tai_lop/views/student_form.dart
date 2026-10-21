import 'package:flutter/material.dart';
import '../models/student.dart';
import '../controllers/student_controller.dart';
import '../utils/ui_helpers.dart';

class StudentForm extends StatefulWidget {
  final SinhVien? item;
  const StudentForm({super.key, this.item});
  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _name.text = widget.item?.name ?? '';
    _email.text = widget.item?.email ?? '';
  }

  Future<void> _save() async {
    if (_saving || !_form.currentState!.validate()) return;
    setState(() { _saving = true; _error = null; });
    try {
      await StudentController().save(SinhVien(
        id: widget.item?.id,
        name: _name.text.trim(),
        email: _email.text.trim(),
      ));
      if (mounted) {
        setState(() => _saving = false);
        Navigator.pop(context, true);
      }
    } catch (_) {
      if (mounted) setState(() {
        _saving = false;
        _error = 'Không thể lưu dữ liệu. Vui lòng thử lại.';
      });
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !_saving,
    child: AlertDialog(
      backgroundColor: const Color(0xFFFFF7FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(widget.item == null ? 'Thêm Sinh Viên' :
      'Thông tin chi tiết của sinh viên'),
      content: SizedBox(
        width: 280,
        child: SingleChildScrollView(child: Form(
          key: _form,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(
              controller: _name,
              enabled: !_saving,
              validator: requiredText,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Tên Sinh Viên'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _email,
              enabled: !_saving,
              validator: validEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            if (_error != null) Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(_error!, style: const TextStyle(color: Colors.red)),
            ),
          ]),
        )),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context, false),
          child: const Text('Hủy'),
        ),
        FilledButton.tonal(
          onPressed: _saving ? null : _save,
          child: Text(_saving ? 'Đang lưu' : widget.item == null ? 'Lưu' : 'Cập nhật'),
        ),
      ],
    ),
  );
}
