import 'MonHoc.dart';
 
// DTB = Điểm tiểu luận*0.3 + Điểm cuối kỳ*0.7
class MonLyThuyet extends MonHoc {
  double diemTieuLuan;
  double diemCuoiKy;
 
  MonLyThuyet.fullPara(String mamh, String tenmh, int sotc,
      this.diemTieuLuan, this.diemCuoiKy)
      : super.coBan(mamh, tenmh, sotc);
 
  @override
  double tinhDTB() {
    return diemTieuLuan * 0.3 + diemCuoiKy * 0.7;
  }
}