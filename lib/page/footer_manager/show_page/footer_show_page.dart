import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:loto/database/data_name.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterShowPage extends StatefulWidget {
  const FooterShowPage({super.key});

  @override
  State<FooterShowPage> createState() => _FooterShowPageState();
}

class _FooterShowPageState extends State<FooterShowPage> {

  Stream<DocumentSnapshot<Object?>> streamGetHelp() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference menuRef = firestore.collection(DataRowName.Menus.name);
    var getHelp = menuRef.doc("Footer").collection('GetHelp').doc("MU0uYBaCGRC9YMfxXDYw");

    return getHelp.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: streamGetHelp(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return HtmlWidget('''${(snapshot.data!.data() as Map<String, dynamic>)["footer_content"]}''',

                // all other parameters are optional, a few notable params:

                // specify custom styling for an element
                // see supported inline styling below
                customStylesBuilder: (element) {
                  if (element.classes.contains('foo')) {
                    return {'color': 'red'};
                  }

                  return null;
                },
                customWidgetBuilder: (element) {
                  if (element.attributes['foo'] == 'bar') {
                    // render a custom widget that takes the full width
                    return Container(
                      width: 150,
                      height: 50,
                      color: Colors.redAccent,
                    );
                  }

                  if (element.attributes['fizz'] == 'buzz') {
                    // render a custom widget that inlines with surrounding text
                    return InlineCustomWidget(
                        child: Container(
                          width: 150,
                          height: 50,
                          color: Colors.blueAccent,
                        )
                    );
                  }

                  return null;
                },

                // this callback will be triggered when user taps a link
                onTapUrl: (url) {
                  launchUrl(Uri.parse(url));
                  return true;
                },


                // select the render mode for HTML body
                // by default, a simple `Column` is rendered
                // consider using `ListView` or `SliverList` for better performance
                renderMode: RenderMode.column,

                // set the default styling for text
                textStyle: TextStyle(fontSize: 14, color: Colors.black),
              );
            }else{
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    //child: Image.network(banner.bannerImage ?? '', fit: BoxFit.fill)
                  ),
                ),
              );
            }
          }
      )
    );
  }

}
