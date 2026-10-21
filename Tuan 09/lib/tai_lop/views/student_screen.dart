import 'package:flutter/material.dart';
import '../models/student.dart';
import '../controllers/student_controller.dart';
import '../utils/ui_helpers.dart';
import 'student_form.dart';

class StudentScreen extends StatefulWidget {
 const StudentScreen({super.key});
 @override
 State<StudentScreen> createState() => _StudentScreenState();
}
class _StudentScreenState extends State<StudentScreen> {
 final _controller = StudentController();
 final _search = TextEditingController();
 List<SinhVien> _items = [];
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
   if (mounted && request == _request) { setState(() => _loading = false);
    notify(context, 'Không thể tải dữ liệu. Hãy thử lại.'); }
  }
 }
 Future<void> _edit([SinhVien? item]) async {
  final saved = await showDialog<bool>(
   context: context,
   barrierDismissible: false,
   builder: (_) => StudentForm(item: item),
  );
  if (mounted && saved == true) await _load();
 }
 Future<void> _delete(SinhVien item) async {
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
  appBar: AppBar(title: const Text('Quản lý sinh viên'),
      actions: [IconButton(onPressed: _load, icon: const Icon(Icons.refresh))]),
  floatingActionButton: FloatingActionButton(onPressed: _deleting ?
  null : () => _edit(), child: const Icon(Icons.add)),
  body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
   TextField(controller: _search, onChanged: (_) => _load(), decoration: InputDecoration(
    hintText: 'Tìm kiếm sinh viên...', prefixIcon: const Icon(Icons.search),
    suffixIcon: IconButton(onPressed: () { _search.clear(); _load(); },
        icon: const Icon(Icons.clear)),
   )),
   const SizedBox(height: 12), 
   Expanded(child: _loading ? const Center(child: CircularProgressIndicator()) : _items.isEmpty
    ? const Center(child: Text('Chưa có dữ liệu phù hợp')) : RefreshIndicator(onRefresh: _load,
       child: ListView.builder(
     padding: const EdgeInsets.only(bottom: 80), itemCount: _items.length,
     itemBuilder: (context, index) {
      final item = _items[index];
      return Card(child: ListTile(
       leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/hinh.png'),
       ),
       title: Text(item.name), subtitle: Text(item.email),
       onTap: _deleting ? null : () => _edit(item),
       trailing: IconButton(onPressed: _deleting ? null : () => _delete(item),
           icon: const Icon(Icons.delete, color: Colors.red)),
      ));
     },
    ))),
  ])),
 );
}
