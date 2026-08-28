import 'package:btvn/hoadon.dart';

class KhachHangCaNhan extends HoaDon {
  double khoangCachGiaoHang = 0.0;

  KhachHangCaNhan() : super();

  KhachHangCaNhan.fullPara(String maKH, String tenKH, int soLuong, double giaBan, this.khoangCachGiaoHang)
      : super.fullPara(maKH, tenKH, soLuong, giaBan);

  @override
  double tinhChietKhau() {
    double ckPerItem = 0;
    if (soLuong >= 3) {
      ckPerItem = giaBan * 0.05;
    }
    if (khoangCachGiaoHang < 10) {
      ckPerItem += 50000;
    }
    return ckPerItem * soLuong;
  }

  @override
  double tinhTroGia() {
    double troGiaCoBan = giaBan * 0.02 * soLuong;
    if (soLuong > 2) {
      return troGiaCoBan + 100000;
    }
    return troGiaCoBan;
  }

  @override
  void xuatThongTin() {
    print("[Cá nhân] Mã KH: $maKH | Tên KH: $tenKH | SL: $soLuong | Giá: $giaBan | VAT: ${tinhVAT()} | CK: ${tinhChietKhau()} | Trợ giá: ${tinhTroGia()} | Thành tiền: ${tinhThanhTien()}");
  }
}