import 'dart:io';

bool laSoNguyenTo(int n) {
  if (n < 2) return false;
  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

void main() {
  List<int> ds = [];
  
  print('Nhập số lượng phần tử của danh sách:');
  int n = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < n; i++) {
    stdout.write('Nhập phần tử thứ ${i + 1}: ');
    ds.add(int.parse(stdin.readLineSync()!));
  }

  // a.
  print('\na. Danh sách vừa nhập: $ds');

  // b. Tính tổng
  int tong = 0;
  for (int x in ds) {
    tong += x;
  }
  print('b. Tổng các phần tử: $tong');

  // c. Xuất số nguyên tố
  List<int> snt = [];
  for (int x in ds) {
    if (laSoNguyenTo(x)) {
      snt.add(x);
    }
  }
  print('c. Các số nguyên tố trong danh sách: $snt');

  // d. Tim / Thêm giá trị
  stdout.write('\nd. Nhập một giá trị bất kỳ: ');
  int x = int.parse(stdin.readLineSync()!);

  if (ds.contains(x)) {
    List<int> viTri = [];
    for (int i = 0; i < ds.length; i++) {
      if (ds[i] == x) viTri.add(i);
    }
    print('Giá trị $x có trong danh sách tại vị trí (index): $viTri');
  } else {
    ds.insert(0, x); 
    print('Giá trị $x không có trong danh sách. Đã thêm vào đầu ds!');
    print('Danh sách mới: $ds');
  }
}