import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loto/base/base_model.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/shopping/about_us/entity/story_line_res.dart';

class TimeLineModel extends BaseModel{

  final RxList<StoryLineRes> listTimeLine = <StoryLineRes>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TimeLineModel(){
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
    CollectionReference collectionRef = firestore.collection(DataRowName.Stories.name);
    var snapshot = await collectionRef.get();
    List<StoryLineRes> listTemp = [];
    for (var data in snapshot.docChanges) {
      var item = data.doc.data() as Map<String, dynamic>;
      listTemp.add(StoryLineRes.fromJson(item));
    }

    listTimeLine.addAll(listTemp);
    //print(listTimeLine.length);
  }

}