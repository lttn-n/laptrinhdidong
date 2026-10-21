import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../controllers/expense_controller.dart';
import '../utils/ui_helpers.dart';
class ExpenseForm extends StatefulWidget {
 final Expense? item;
 const ExpenseForm({super.key, this.item});
 @override
 State<ExpenseForm> createState() => _ExpenseFormState();
}
class _ExpenseFormState extends State<ExpenseForm> {
 final _form = GlobalKey<FormState>();
 final _content = TextEditingController();
 final _amount = TextEditingController();
 final _note = TextEditingController();
 bool _saving = false;
 @override
 void initState() { super.initState(); _content.text = widget.item?.content ?? '';
  _amount.text = widget.item?.amount.toString() ?? '';
  _note.text = widget.item?.note ?? ''; }
 String? _validAmount(String? value) {
 final text = value?.trim() ?? '';
 final amount = int.tryParse(text);
 if (!RegExp(r'^\d+$').hasMatch(text) || amount == null || amount <= 0 || amount > 1000000000000)
  return 'Nhập số tiền nguyên từ 1 đến 1.000.000.000.000';
 return null;
}
 Future<void> _save() async {
  if (_saving || !_form.currentState!.validate()) return;
  setState(() => _saving = true);
  try {
   await ExpenseController().save(Expense(id: widget.item?.id, content: _content.text.trim(),
       amount: int.parse(_amount.text.trim()), note: _note.text.trim()));
   if (mounted) Navigator.pop(context, true);
  } catch (_) { if (mounted) notify(context, 'Không thể lưu dữ liệu'); }
  finally { if (mounted) setState(() => _saving = false); }
 }
 @override
 void dispose() { _content.dispose(); _amount.dispose(); _note.dispose(); super.dispose(); }
 @override
 Widget build(BuildContext context) => Scaffold(
  appBar: AppBar(title: Text(widget.item == null ? 'Thêm chi tiêu' : 'Chi tiết chi tiêu')),
  body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Form(key: _form, child: Column(children: [
   if (widget.item != null) Text('ID: ${widget.item!.id}'),
   TextFormField(controller: _content, validator: requiredText, keyboardType: TextInputType.text,
       decoration: const InputDecoration(labelText: 'Nội dung chi tiêu')), const SizedBox(height: 16),
   TextFormField(controller: _amount, validator: _validAmount, keyboardType: TextInputType.number,
       decoration: const InputDecoration(labelText: 'Số tiền (đồng)')), const SizedBox(height: 16),
   TextFormField(controller: _note, validator: null, keyboardType: TextInputType.text,
       decoration: const InputDecoration(labelText: 'Ghi chú')), const SizedBox(height: 16),
   Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    TextButton(onPressed: _saving ? null : () => Navigator.pop(context), child: const Text('Hủy')),
    FilledButton(onPressed: _saving ? null : _save,
        child: Text(_saving ? 'Đang lưu...' : widget.item == null ? 'Lưu' : 'Cập nhật')),
   ]),
  ]))),
 );
}
