import 'package:btvn/hoadon.dart';

class DaiLyCap1 extends HoaDon {
  int thoiGianHopTac = 0;

  DaiLyCap1() : super();

  DaiLyCap1.fullPara(String maKH, String tenKH, int soLuong, double giaBan, this.thoiGianHopTac)
      : super.fullPara(maKH, tenKH, soLuong, giaBan);

  @override
  double tinhChietKhau() {
    double phanTramCK = 0.30;
    if (thoiGianHopTac > 5) {
      int soNamThem = thoiGianHopTac - 5;
      phanTramCK += soNamThem * 0.01;
      if (phanTramCK > 0.35) {
        phanTramCK = 0.35;
      }
    }
    return (soLuong * giaBan) * phanTramCK;
  }

  @override
  double tinhTroGia() {
    return 0.0;
  }

  @override
  void xuatThongTin() {
    print("[Đại lý cấp 1] Mã KH: $maKH | Tên KH: $tenKH | SL: $soLuong | Giá: $giaBan | VAT: ${tinhVAT()} | CK: ${tinhChietKhau()} | Trợ giá: ${tinhTroGia()} | Thành tiền: ${tinhThanhTien()}");
  }
}