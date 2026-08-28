abstract class MonHoc {
  String _maMH = '';
  String _tenMH = '';
  int _soTC = 0;
 
  MonHoc();
  MonHoc.coBan(String mamh, String tenmh, int sotc) {
    _maMH = mamh;
    _tenMH = tenmh;
    _soTC = sotc;
  }
 
  String get maMH {
    return _maMH;
  }
  String get tenMH {
    return _tenMH;
  }
  int get soTC {
    return _soTC;
  }
 
  // Mỗi loại môn học có công thức DTB khác nhau
  double tinhDTB();
 
  // Quy đổi điểm hệ 10 sang điểm chữ (hệ 4)
  String quyDoiDiemChu() {
    double dtb = tinhDTB();
    if (dtb >= 8.5) return 'A';
    if (dtb >= 7.0) return 'B';
    if (dtb >= 5.5) return 'C';
    if (dtb >= 4.0) return 'D';
    return 'F';
  }
 
  @override
  String toString() {
    return "$_maMH\t$_tenMH\t$_soTC tín chỉ\t"
        "DTB: ${tinhDTB().toStringAsFixed(2)}\tĐiểm chữ: ${quyDoiDiemChu()}";
  }
}