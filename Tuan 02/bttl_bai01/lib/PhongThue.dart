abstract class PhongThue {
  String _maPhong = '';
  int _soNguoiO = 0;
  double _soDien = 0;
  double _soNuoc = 0;
 
  PhongThue();
 
  PhongThue.coBan(
      String maphong, int songuoi, double sodien, double sonuoc) {
    _maPhong = maphong;
    _soNguoiO = songuoi;
    _soDien = sodien;
    _soNuoc = sonuoc;
  }
 
  String get maPhong => _maPhong;
  int get soNguoiO => _soNguoiO;
  double get soDien => _soDien;
  double get soNuoc => _soNuoc;
 

  double tinhTienPhong();
 
  @override
  String toString() {
    return "Mã phòng: $_maPhong, số người ở: $_soNguoiO, "
        "số điện: $_soDien, số nước: $_soNuoc, "
        "tiền phòng: ${tinhTienPhong()}";
  }
}