import 'dart:io';
void main(){
  print('Nhập vào 1 số nguyên dương > 10: ');
  int n = int.parse(stdin.readLineSync()!);

  if(n<=10){
    print('n phải là số nguyên dương > 10');
    return;
  }
  int temp = n;
  int dem = 0;
  int tong = 0;
  bool laSole = false;

  while(temp>0){
    int chuSo = temp % 10;
    dem++; //câu a
    tong += chuSo; //câu b

    if(chuSo % 2 !=0){
      laSole = true;
    }
    temp ~/= 10;
  }

  print('KQ câu a: Số $n có $dem chữ số');
  print('KQ câu b: Tổng các chữ số là: $tong');
  
  if(laSole){
    print('KQ câu c: Số $n có chứa chữ số lẻ');
  }else{
    print('KQ câu c: Số $n không chứa chữ số lẻ');
  }
}