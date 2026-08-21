import 'dart:io';
import 'dart:math';

void main() {
  print('Nhập số lượng phần tử muốn tạo ngẫu nhiên:');
  int n = int.parse(stdin.readLineSync()!);

  // ds random
  Random rand = Random();
  List<int> ds = List.generate(n, (_) => rand.nextInt(96) + 5);

  // a. Xuất danh sách
  print('\na. Danh sách ngẫu nhiên tạo ra: $ds');

  // b. Trung bình cộng các số lẻ
  int tongLe = 0;
  int demLe = 0;
  for (int x in ds) {
    if (x % 2 != 0) {
      tongLe += x;
      demLe++;
    }
  }
  if (demLe > 0) {
    print('b. Trung bình cộng các số lẻ: ${tongLe / demLe}');
  } else {
    print('b. Danh sách không có số lẻ.');
  }

  // c. Kiểm tra danh sách đối xứng
  bool doiXung = true;
  for (int i = 0; i < ds.length ~/ 2; i++) {
    if (ds[i] != ds[ds.length - 1 - i]) {
      doiXung = false;
      break;
    }
  }
  print('c. Danh sách ${doiXung ? "đối xứng" : "không đối xứng"}');

  // d. Kiểm tra sắp xếp tăng dần
  bool tangDan = true;
  for (int i = 0; i < ds.length - 1; i++) {
    if (ds[i] > ds[i + 1]) {
      tangDan = false;
      break;
    }
  }
  print('d. Danh sách ${tangDan ? "Đã sắp xếp tăng dần" : "Chưa sắp xếp tăng dần"}');

  // e. Tìm phần tử lớn nhất
  int maxVal = ds[0];
  for (int x in ds) {
    if (x > maxVal) maxVal = x;
  }
  print('e. Phần tử lớn nhất: $maxVal');

  // f. Tìm phần tử chẵn lớn nhất
  int? maxChan;
  for (int x in ds) {
    if (x % 2 == 0) {
      if (maxChan == null || x > maxChan) {
        maxChan = x;
      }
    }
  }
  if (maxChan != null) {
    print('f. Phần tử chẵn lớn nhất: $maxChan');
  } else {
    print('f. Danh sách không có số chẵn.');
  }

  // g. Tìm và xóa phần tử
  stdout.write('\ng. Nhập một giá trị cần tìm: ');
  int val = int.parse(stdin.readLineSync()!);

  if (!ds.contains(val)) {
    print('Không tìm thấy.');
  } else {
    ds.removeWhere((item) => item == val);
    print('Đã xóa tất cả phần tử có giá trị $val.');
    print('Danh sách sau khi xóa: $ds');
  }
}