import 'package:flutter/material.dart';

class SelectNumberWidget extends StatelessWidget {
  final List<int> listNumber;
  const SelectNumberWidget({Key? key, required this.listNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text("Chọn số", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          GridView.builder(
            itemCount: listNumber.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.pop(context, listNumber[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    color: Colors.blue,
                  ),
                  alignment: Alignment.center,
                  child: Text((listNumber[index]).toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 9,
                childAspectRatio: 1,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2
            ),
          ),
          Spacer(flex: 1),
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
