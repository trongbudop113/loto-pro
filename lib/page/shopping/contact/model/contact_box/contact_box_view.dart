import 'package:flutter/material.dart';
import 'package:loto/page/shopping/contact/model/contact_box/contact_box_model.dart';

class ContactBoxView extends StatelessWidget{
  final ContactBoxModel model;
  const ContactBoxView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64).copyWith(top: 63),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 73),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your email address will not be published. Required fields are marked*",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 14,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.red,
                          height: 57,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.red,
                          height: 57,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30,),
                  AspectRatio(
                    aspectRatio: 593 / 350,
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Container(
                    width: 160,
                    height: 40,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 644 / 563,
              child: Container(
                color: Colors.red,
              ),
            )
          )
        ],
      ),
    );
  }

}