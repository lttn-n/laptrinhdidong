import 'MonHoc.dart';
 
// DTB = (điểm GVHD + điểm GVPB) / 2
class MonDoAn extends MonHoc {
  double diemGVHD;
  double diemGVPB;
 
  MonDoAn.fullPara(
      String mamh, String tenmh, int sotc, this.diemGVHD, this.diemGVPB)
      : super.coBan(mamh, tenmh, sotc);
 
  @override
  double tinhDTB() {
    return (diemGVHD + diemGVPB) / 2;
  }
}