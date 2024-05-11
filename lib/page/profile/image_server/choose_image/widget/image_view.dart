import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageView extends StatefulWidget {
  final Future<String>? getFullImage;
  final Function(String data)? onSelectData;
  final Function(String data)? onRemoveSelect;
  const ImageView({super.key, required this.getFullImage, this.onSelectData, this.onRemoveSelect});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  final RxBool isSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: widget.getFullImage,
      builder: (c, snapshot){
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return GestureDetector(
          onTap: (){
            if(isSelected.value){
              widget.onRemoveSelect?.call(snapshot.data ?? '');
              isSelected.value = false;
            }else{
              widget.onSelectData?.call(snapshot.data ?? '');
              isSelected.value = true;
            }
          },
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.grey,
                child: Image.network(
                  snapshot.data ?? '',
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: 10,
                right: 10,
                child: Obx(() => Visibility(
                  visible: isSelected.value,
                  child: const Icon(
                      Icons.check_circle,
                    color: Colors.green,
                  ),
                )),
              )
            ],
          ),
        );
      },
    );
  }
}
