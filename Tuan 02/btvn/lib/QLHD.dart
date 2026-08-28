import 'package:btvn/hoadon.dart';
import 'package:btvn/KHcongty.dart';

class QuanLyHoaDon {
  List<HoaDon> danhSachHD = [];

  void themHoaDon(HoaDon hd) {
    danhSachHD.add(hd);
  }

  void xuatDanhSach() {
    if (danhSachHD.isEmpty) {
      print("Danh sách hóa đơn trống!");
      return;
    }
    for (var hd in danhSachHD) {
      hd.xuatThongTin();
    }
  }

  double tinhTongThanhTien() {
    double tong = 0;
    for (var hd in danhSachHD) {
      tong += hd.tinhThanhTien();
    }
    return tong;
  }

  double tinhTongTroGia() {
    double tong = 0;
    for (var hd in danhSachHD) {
      tong += hd.tinhTroGia();
    }
    return tong;
  }

  void hienThiKhachHangMuaNhieuNhat() {
    if (danhSachHD.isEmpty) {
      print("Danh sách trống!");
      return;
    }
    HoaDon maxHD = danhSachHD[0];
    for (var hd in danhSachHD) {
      if (hd.soLuong > maxHD.soLuong) {
        maxHD = hd;
      }
    }
    print("--- Khách hàng mua nhiều nhất (${maxHD.soLuong} sản phẩm) ---");
    maxHD.xuatThongTin();
  }

  double tinhTongChietKhauKhachHangCongTy() {
    double tongCK = 0;
    for (var hd in danhSachHD) {
      if (hd is KhachHangCongTy) {
        tongCK += hd.tinhChietKhau();
      }
    }
    return tongCK;
  }

  void sapXepHoaDon() {
    danhSachHD.sort((a, b) {
      int cmp = a.soLuong.compareTo(b.soLuong);
      if (cmp != 0) {
        return cmp;
      }
      return b.tinhThanhTien().compareTo(a.tinhThanhTien());
    });
  }

  void timKiemTheoMaKH(String maX) {
    List<HoaDon> ketQua = [];
    for (var hd in danhSachHD) {
      if (hd.maKH == maX) {
        ketQua.add(hd);
      }
    }
    if (ketQua.isEmpty) {
      print("Khách hàng lạ");
    } else {
      print("Các hóa đơn của khách hàng có mã $maX:");
      for (var hd in ketQua) {
        hd.xuatThongTin();
      }
    }
  }
}