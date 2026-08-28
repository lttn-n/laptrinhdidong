import 'PhongThue.dart';
 
// Tiền phòng = 1400 + 2*Số điện + 8*Số nước + 50*SoNguoithan
class PhongA extends PhongThue {
  double _soNguoiThan = 0;
 
  PhongA.fullPara(String maphong, int songuoi, double sodien,
      double sonuoc, double songuoithan)
      : super.coBan(maphong, songuoi, sodien, sonuoc) {
    _soNguoiThan = songuoithan;
  }
 
  double get soNguoiThan {
    return _soNguoiThan;
  }
 
  @override
  double tinhTienPhong() {
    return 1400 + 2 * soDien + 8 * soNuoc + 50 * _soNguoiThan;
  }
 
  @override
  String toString() {
    return "${super.toString()} | Loại A - số người thân: $_soNguoiThan";
  }
}