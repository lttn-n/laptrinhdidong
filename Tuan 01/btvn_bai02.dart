import 'dart:convert'; 
import 'dart:io';

void main() {
  // Bật chế độ xuất dữ liệu UTF-8 ra Terminal
  stdout.encoding = utf8;

  // a. Nhập và xuất chuỗi 
  stdout.write('a. Nhập vào 1 chuỗi: ');
  String s = stdin.readLineSync(encoding: utf8) ?? '';
  print('   Chuỗi vừa nhập: $s');

  // b. Đếm số ký tự nguyên âm
  String nguyenAm = 'aeiouAEIOUàáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹ';// nguyên âm TV 
  int demNguyenAm = 0;
  for (int i = 0; i < s.length; i++) {
    if (nguyenAm.contains(s[i])) {
      demNguyenAm++;
    }
  }
  print('b. Số ký tự nguyên âm: $demNguyenAm');

  // c. Đếm số từ
  List<String> dsTu = s.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
  print('c. Số từ trong chuỗi: ${dsTu.length}');

  // d. Kiểm tra chuỗi đối xứng
  String sChuanHoa = s.replaceAll(' ', '').toLowerCase();
  String sDaoNguoc = sChuanHoa.split('').reversed.join('');
  if (sChuanHoa.isNotEmpty && sChuanHoa == sDaoNguoc) {
    print('d. Chuỗi ĐỐI XỨNG');
  } else {
    print('d. Chuỗi KHÔNG ĐỐI XỨNG');
  }

  // e. Đảo ngược các từ trong chuỗi
  if (dsTu.isNotEmpty) {
    String chuoiDaoTu = dsTu.reversed.join(' ');
    print('e. Đảo ngược các từ: $chuoiDaoTu');
  } else {
    print('e. Chuỗi không có từ nào để đảo!');
  }
}