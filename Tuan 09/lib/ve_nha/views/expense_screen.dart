import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../controllers/expense_controller.dart';
import '../utils/ui_helpers.dart';
import 'expense_form.dart';
String money(int value) => value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '.');
class ExpenseScreen extends StatefulWidget {
 const ExpenseScreen({super.key});
 @override
 State<ExpenseScreen> createState() => _ExpenseScreenState();
}
class _ExpenseScreenState extends State<ExpenseScreen> {
 final _controller = ExpenseController();
 final _search = TextEditingController();
 List<Expense> _items = [];
 bool _loading = true;
 bool _deleting = false;
 int _request = 0;
 @override
 void initState() { super.initState(); _load(); }
 Future<void> _load() async {
  final request = ++_request;
  try {
   final items = await _controller.fetchAll(_search.text.trim());
   if (mounted && request == _request) setState(() { _items = items; _loading = false; });
  } catch (_) {
   if (mounted && request == _request) { setState(() => _loading = false); notify(context, 'Không thể tải dữ liệu. Hãy thử lại.'); }
  }
 }
 Future<void> _edit([Expense? item]) async {
  await Navigator.push<bool>(context, MaterialPageRoute(builder: (_) => ExpenseForm(item: item)));
  if (mounted) await _load();
 }
 Future<void> _delete(Expense item) async {
  if (_deleting || !await confirmDelete(context) || !mounted) return;
  setState(() => _deleting = true);
  try { await _controller.delete(item.id!); await _load(); }
  catch (_) { if (mounted) notify(context, 'Không thể xóa dữ liệu'); }
  finally { if (mounted) setState(() => _deleting = false); }
 }
 @override
 void dispose() { _search.dispose(); super.dispose(); }
 @override
 Widget build(BuildContext context) => Scaffold(
  appBar: AppBar(title: const Text('Quản lý chi tiêu'), actions: [IconButton(onPressed: _load, icon: const Icon(Icons.refresh))]),
  floatingActionButton: FloatingActionButton(onPressed: _deleting ? null : () => _edit(), child: const Icon(Icons.add)),
  body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
   TextField(controller: _search, onChanged: (_) => _load(), decoration: InputDecoration(
    hintText: 'Tìm kiếm chi tiêu...', prefixIcon: const Icon(Icons.search),
    suffixIcon: IconButton(onPressed: () { _search.clear(); _load(); }, icon: const Icon(Icons.clear)),
   )),
   const SizedBox(height: 12), Text('Tổng chi tiêu đang hiển thị: ${money(_items.fold<int>(0, (sum, item) => sum + item.amount))} đ',
       style: const TextStyle(fontWeight: FontWeight.bold)),
   Expanded(child: _loading ? const Center(child: CircularProgressIndicator()) : _items.isEmpty
    ? const Center(child: Text('Chưa có dữ liệu phù hợp')) : RefreshIndicator(onRefresh: _load, child: ListView.builder(
     padding: const EdgeInsets.only(bottom: 80), itemCount: _items.length,
     itemBuilder: (context, index) {
      final item = _items[index];
      return Card(child: ListTile(
       leading: const CircleAvatar(child: Icon(Icons.payments)),
       title: Text(item.content), subtitle: Text('${money(item.amount)} đ\n${item.note}'),
       onTap: _deleting ? null : () => _edit(item),
       trailing: IconButton(onPressed: _deleting ? null : () => _delete(item), icon: const Icon(Icons.delete, color: Colors.red)),
      ));
     },
    ))),
  ])),
 );
}
