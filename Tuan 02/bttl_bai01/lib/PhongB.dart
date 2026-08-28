import 'PhongThue.dart';
 
// Tiền phòng = 2000 + 2*Số điện + 8*Số nước + Giatui*5 + Somay*100
class PhongB extends PhongThue {
  double _giatui = 0;
  double _somay = 0;
 
  PhongB.fullPara(String maphong, int songuoi, double sodien,
      double sonuoc, double giatui, double somay)
      : super.coBan(maphong, songuoi, sodien, sonuoc) {
    _giatui = giatui;
    _somay = somay;
  }
 
  @override
  double tinhTienPhong() {
    return 2000 + 2 * soDien + 8 * soNuoc + _giatui * 5 + _somay * 100;
  }
 
  @override
  String toString() {
    return "${super.toString()} | Loại B - giặt ủi: $_giatui, số máy: $_somay";
  }
}