import 'MonHoc.dart';
 
// DTB = trung bình cộng 3 cột điểm kiểm tra
class MonThucHanh extends MonHoc {
  List<double> diemKT;
 
  MonThucHanh.fullPara(String mamh, String tenmh, int sotc, this.diemKT)
      : super.coBan(mamh, tenmh, sotc);
 
  @override
  double tinhDTB() {
    if (diemKT.isEmpty) return 0;
    return diemKT.reduce((a, b) => a + b) / diemKT.length;
  }
}