import 'dart:io';
import 'package:bttl_bai02/MonHoc.dart';
import 'package:bttl_bai02/MonLyThuyet.dart';
import 'package:bttl_bai02/MonThucHanh.dart';
import 'package:bttl_bai02/MonDoAn.dart';
 
Future<List<MonHoc>> docFile(String tenFile) async {
  List<MonHoc> ds = [];
  List<String> lines = await File(tenFile).readAsLines();
  for (String line in lines) {
    List<String> p = line.split('#');
    String loai = p[0], ma = p[1], ten = p[2];
    int tc = int.parse(p[3]);
    if (loai == 'LT') {
      ds.add(MonLyThuyet.fullPara(
          ma, ten, tc, double.parse(p[4]), double.parse(p[5])));
    } else if (loai == 'TH') {
      List<double> diem = p.sublist(4).map((e) => double.parse(e)).toList();
      ds.add(MonThucHanh.fullPara(ma, ten, tc, diem));
    } else if (loai == 'DA') {
      ds.add(MonDoAn.fullPara(
          ma, ten, tc, double.parse(p[4]), double.parse(p[5])));
    }
  }
  return ds;
}
 
void main() async {
  List<MonHoc> dsMon = [];
 
  print('Nhập số lượng môn học cần nhập: ');
  int n = int.parse(stdin.readLineSync()!);
 
  for (int i = 0; i < n; i++) {
    print('--- Môn học thứ ${i + 1} ---');
    stdout.write('Mã môn học: ');
    String ma = stdin.readLineSync()!;
    stdout.write('Tên môn học: ');
    String ten = stdin.readLineSync()!;
    stdout.write('Số tín chỉ: ');
    int tc = int.parse(stdin.readLineSync()!);
    stdout.write('Loại (1-Lý thuyết, 2-Thực hành, 3-Đồ án): ');
    int loai = int.parse(stdin.readLineSync()!);
 
    if (loai == 1) {
      stdout.write('Điểm tiểu luận: ');
      double tl = double.parse(stdin.readLineSync()!);
      stdout.write('Điểm cuối kỳ: ');
      double ck = double.parse(stdin.readLineSync()!);
      dsMon.add(MonLyThuyet.fullPara(ma, ten, tc, tl, ck));
    } else if (loai == 2) {
      List<double> diem = [];
      for (int j = 1; j <= 3; j++) {
        stdout.write('Điểm kiểm tra $j: ');
        diem.add(double.parse(stdin.readLineSync()!));
      }
      dsMon.add(MonThucHanh.fullPara(ma, ten, tc, diem));
    } else {
      stdout.write('Điểm GVHD: ');
      double gvhd = double.parse(stdin.readLineSync()!);
      stdout.write('Điểm GVPB: ');
      double gvpb = double.parse(stdin.readLineSync()!);
      dsMon.add(MonDoAn.fullPara(ma, ten, tc, gvhd, gvpb));
    }
  }
 
  print('\n--- Danh sách môn học vừa nhập ---');
  for (var m in dsMon) print(m);
 
  bool daSapXep = true;
  for (int i = 0; i < dsMon.length - 1; i++) {
    if (dsMon[i].tenMH.compareTo(dsMon[i + 1].tenMH) > 0) {
      daSapXep = false;
      break;
    }
  }
  print('\nDanh sách đã sắp xếp tăng dần theo tên chưa? $daSapXep');
 
  dsMon.sort((a, b) => a.soTC.compareTo(b.soTC));
  print('\n--- Sắp xếp tăng dần theo số tín chỉ ---');
  for (var m in dsMon) print(m);
 
  int maxTC = dsMon.map((m) => m.soTC).reduce((a, b) => a > b ? a : b);
  print('\n--- Các môn có số tín chỉ cao nhất ($maxTC) ---');
  for (var m in dsMon.where((m) => m.soTC == maxTC)) print(m);
 
  stdout.write('\nNhập tên môn học cần tìm: ');
  String tenTim = stdin.readLineSync()!;
  var ketQua = dsMon.where((m) => m.tenMH == tenTim);
  if (ketQua.isEmpty) {
    print('Không có trong danh sách -> thêm mới vào cuối danh sách.');
    dsMon.add(MonLyThuyet.fullPara('MHxxx', tenTim, 2, 0, 0));
  } else {
    print('Đã có trong danh sách: ${ketQua.first}');
  }
 
  // Đọc thêm từ file (ít nhất 5 môn học)
  List<MonHoc> dsTuFile = await docFile('lib/monhoc.txt');
  print('\n--- Danh sách đọc từ file monhoc.txt ---');
  for (var m in dsTuFile) print(m);
 
  double tbTC = dsMon.fold(0, (sum, m) => sum + m.soTC) / dsMon.length;
  print('\nSố tín chỉ trung bình: ${tbTC.toStringAsFixed(2)}');
}