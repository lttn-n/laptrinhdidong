import 'package:btvn/hoadon.dart';

class KhachHangCongTy extends HoaDon {
  int soLuongNhanVien = 0;

  KhachHangCongTy() : super();

  KhachHangCongTy.fullPara(String maKH, String tenKH, int soLuong, double giaBan, this.soLuongNhanVien)
      : super.fullPara(maKH, tenKH, soLuong, giaBan);

  @override
  double tinhChietKhau() {
    double phanTramCK = 0.0;
    if (soLuongNhanVien > 5000) {
      phanTramCK = 0.07;
    } else if (soLuongNhanVien > 1000) {
      phanTramCK = 0.05;
    }
    return (soLuong * giaBan) * phanTramCK;
  }

  @override
  double tinhTroGia() {
    return 120000.0 * soLuong;
  }

  @override
  void xuatThongTin() {
    print("[Công ty] Mã KH: $maKH | Tên KH: $tenKH | SL: $soLuong | Giá: $giaBan | VAT: ${tinhVAT()} | CK: ${tinhChietKhau()} | Trợ giá: ${tinhTroGia()} | Thành tiền: ${tinhThanhTien()}");
  }
}