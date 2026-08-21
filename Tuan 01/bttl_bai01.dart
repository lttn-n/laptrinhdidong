import 'dart:io';

void main(){
  print('Nhập số lượng que kem: ');
  int sl = int.parse(stdin.readLineSync()!);

  if(sl <= 0){
    print('Số lượng que kem phải lớn hơn 0');
    return;
  }

  print('Nhập giá tiền của 1 que kem: ');
  double price = double.parse(stdin.readLineSync()!);

  double tong = sl * price;
  if(sl > 10){
    tong = tong * 0.9;
  }
  else if(sl >= 5){
    tong = tong * 0.95;
  }

  print('Số tiền phải trả là: $tong');
} 