import 'dart:io';
import '../lib/PhongThue.dart';
import '../lib/PhongA.dart';
import '../lib/PhongB.dart';
 
Future<List<PhongThue>> docFile(String tenFile) async {
  List<PhongThue> ds = [];
  try {
    List<String> lines = await File(tenFile).readAsLines();
    for (String line in lines) {
      List<String> p = line.split('#');
      if (p[0].startsWith('A') && p.length == 5) {
        ds.add(PhongA.fullPara(p[0], int.parse(p[1]), double.parse(p[2]), double.parse(p[3]), double.parse(p[4])));
      } else if (p[0].startsWith('B') && p.length == 6) {
        ds.add(PhongB.fullPara(p[0], int.parse(p[1]), double.parse(p[2]), double.parse(p[3]), double.parse(p[4]), double.parse(p[5])));
      }
    }
  } catch (e) {
    print('Lỗi khi đọc file: $e');
  }
  return ds;
}
 
void main() async {
  List<PhongThue> dsPhong = await docFile('../lib/phongthue.txt');
 
  print('--- Danh sách phòng thuê ---');
  for (var ph in dsPhong) print(ph);
 
  print('\n--- Phòng có số người ở > 2 ---');
  for (var ph in dsPhong.where((x) => x.soNguoiO > 2)) print(ph);
 
  double tongTien = dsPhong.fold(0, (sum, x) => sum + x.tinhTienPhong());
  print('\nTổng tiền phòng thu được: $tongTien');
 
  dsPhong.sort((a, b) => b.soDien.compareTo(a.soDien));
  print('\n--- Sắp xếp giảm dần theo số điện ---');
  for (var ph in dsPhong) print(ph);
 
  print('\n--- Danh sách phòng loại A ---');
  for (var ph in dsPhong.whereType<PhongA>()) print(ph);
}