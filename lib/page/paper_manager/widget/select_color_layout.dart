import 'package:flutter/material.dart';
import 'package:loto/page/paper_manager/models/category_paper.dart';
import 'package:loto/page/paper_manager/paper_manager_controller.dart';

class SelectColorLayout extends StatelessWidget {
  final List<CategoryPaper> listCategoryPaper;
  final PaperManagerController controller;
  const SelectColorLayout({Key? key, required this.listCategoryPaper, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text("Chọn màu", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: listCategoryPaper.length,
              itemBuilder: (c, i){
                return GestureDetector(
                  child: Container(
                    height: 40,
                    color: Color(controller.convertColor(listCategoryPaper[i].color ?? '')),
                    child: Text(listCategoryPaper[i].paperName ?? ''),
                    alignment: Alignment.center,
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    controller.onSelectPaper(listCategoryPaper[i]);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 8,
                );
              },
            ),
          ),
          GestureDetector(
            child: Container(
              child: Text("Đóng", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue[200],
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
