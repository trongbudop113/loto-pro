import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_http_request.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/blog/model_data/testimonial_product_res.dart';
import 'package:loto/page/shopping/home/home_controller.dart';

class BlogEventModel extends BaseModel{

  final RxList<TestimonialProductRes> listTestimonial = <TestimonialProductRes>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  BlogEventModel(){
    onStart();
  }

  @override
  void onFinish() {
    // TODO: implement onFinish
  }

  @override
  void onStart() {
    initData();
  }

  Future<void> initData() async {
    try{
      CollectionReference cakeRef = firestore.collection(DataRowName.Testimonials.name);
      var snapshot = await cakeRef.get();

      List<TestimonialProductRes> listTemp = [];
      for (var data in snapshot.docChanges) {
        var item = data.doc.data() as Map<String, dynamic>;
        listTemp.add(TestimonialProductRes.fromJson(item));
      }

      print(listTemp.length);
      listTestimonial.addAll(listTemp);
      Get.find<HomeController>().testimonialModel.setListTestimonial(listTemp);
    }catch(e){
      print(e);
    }
  }
}