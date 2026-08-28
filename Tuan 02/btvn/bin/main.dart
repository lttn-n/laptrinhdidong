import 'dart:io';
import 'package:btvn/hoadon.dart';
import 'package:btvn/KHcanhan.dart';
import 'package:btvn/dailycap1.dart';
import 'package:btvn/KHcongty.dart';
import 'package:btvn/QLHD.dart';

void main() {
  QuanLyHoaDon qlhd = QuanLyHoaDon();

  try {
    HoaDon hd1 = KhachHangCaNhan.fullPara("KH0001", "Nguyễn Văn A", 4, 5000000, 5.0);
    HoaDon hd2 = DaiLyCap1.fullPara("KH0002", "Đại lý Điện máy Xanh", 20, 4800000, 7);
    HoaDon hd3 = KhachHangCongTy.fullPara("KH0003", "Công ty TNHH Tech", 15, 5200000, 6000);
    HoaDon hd4 = KhachHangCaNhan.fullPara("KH0004", "Trần Thị B", 2, 4500000, 15.0);

    qlhd.themHoaDon(hd1);
    qlhd.themHoaDon(hd2);
    qlhd.themHoaDon(hd3);
    qlhd.themHoaDon(hd4);

    print("=== 1. DANH SÁCH HÓA ĐƠN BAN ĐẦU ===");
    qlhd.xuatDanhSach();

    print("\n=== 2. TỔNG THÀNH TIỀN TẤT CẢ HÓA ĐƠN ===");
    print("${qlhd.tinhTongThanhTien()} VNĐ");

    print("\n=== 3. TỔNG TIỀN TRỢ GIÁ CỦA CÔNG TY ===");
    print("${qlhd.tinhTongTroGia()} VNĐ");

    print("\n=== 4. KHÁCH HÀNG CÓ SỐ LƯỢNG MUA NHIỀU NHẤT ===");
    qlhd.hienThiKhachHangMuaNhieuNhat();

    print("\n=== 5. TỔNG CHIẾT KHẤU ĐỐI VỚI KHÁCH HÀNG CÔNG TY ===");
    print("${qlhd.tinhTongChietKhauKhachHangCongTy()} VNĐ");

    print("\n=== 6. DANH SÁCH SAU KHI SẮP XẾP ===");
    qlhd.sapXepHoaDon();
    qlhd.xuatDanhSach();

    print("\n=== 7. TÌM KIẾM THEO MÃ KHÁCH HÀNG ===");
    stdout.write("Nhập mã khách hàng cần tìm (VD: KH0001): ");
    String maTimKiem = stdin.readLineSync() ?? '';
    qlhd.timKiemTheoMaKH(maTimKiem);

  } catch (e) {
    print("Lỗi: $e");
  }
}