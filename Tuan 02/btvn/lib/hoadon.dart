class HoaDon {
  String _maKH = '';
  String _tenKH = '';
  int _soLuong = 0;
  double _giaBan = 0.0;

  HoaDon() {
    _maKH = "KH0000";
    _tenKH = "Chưa có tên";
    _soLuong = 1;
    _giaBan = 100000.0;
  }

  HoaDon.fullPara(String maKH, String tenKH, int soLuong, double giaBan) {
    setMaKH(maKH);
    setTenKH(tenKH);
    setSoLuong(soLuong);
    setGiaBan(giaBan);
  }

  String get maKH {
    return _maKH;
  }
  
  void setMaKH(String value) {
    RegExp regExp = RegExp(r'^KH\d{4}$');
    if (regExp.hasMatch(value)) {
      _maKH = value;
    } else {
      throw FormatException("Lỗi: Mã khách hàng '$value' không đúng định dạng (Phải là KHxxxx)!");
    }
  }

  String get tenKH {
    return _tenKH;
  }
  
  void setTenKH(String value) {
    if (value.trim().isNotEmpty) {
      _tenKH = value;
    } else {
      throw ArgumentError("Lỗi: Tên khách hàng không được để trống!");
    }
  }

  int get soLuong {
    return _soLuong;
  }
  
  void setSoLuong(int value) {
    if (value > 0) {
      _soLuong = value;
    } else {
      throw ArgumentError("Lỗi: Số lượng phải lớn hơn 0!");
    }
  }

  double get giaBan {
    return _giaBan;
  }
  
  void setGiaBan(double value) {
    if (value > 0) {
      _giaBan = value;
    } else {
      throw ArgumentError("Lỗi: Giá bán phải lớn hơn 0!");
    }
  }

  double tinhChietKhau() {
    return 0.0;
  }
  
  double tinhTroGia() {
    return 0.0;
  }

  double tinhVAT() {
    return _soLuong * _giaBan * 0.10;
  }

  double tinhThanhTien() {
    double thanhTien = (_soLuong * _giaBan) - tinhChietKhau() + tinhVAT();
    return thanhTien > 0 ? thanhTien : 0;
  }

  void xuatThongTin() {
    print("Mã KH: $_maKH | Tên KH: $_tenKH | SL: $_soLuong | Giá: $_giaBan | VAT: ${tinhVAT()} | CK: ${tinhChietKhau()} | Trợ giá: ${tinhTroGia()} | Thành tiền: ${tinhThanhTien()}");
  }
}