import 'package:flutter/material.dart';
void notify(BuildContext context, String message) {
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
String? requiredText(String? value) => value == null || value.trim().isEmpty ? 'Vui lòng nhập thông tin' : null;
String? validEmail(String? value) {
 if (requiredText(value) != null) return 'Vui lòng nhập email';
 return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value!.trim()) ? null : 'Email không hợp lệ';
}
Future<bool> confirmDelete(BuildContext context) async => await showDialog<bool>(
 context: context,
 builder: (dialogContext) => AlertDialog(
  title: const Text('Xác nhận xóa'), content: const Text('Bạn có muốn xóa mục này không?'),
  actions: [TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Hủy')),
   FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Xóa'))],
 ),
) ?? false;
