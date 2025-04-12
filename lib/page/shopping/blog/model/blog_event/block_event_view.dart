import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loto/page/shopping/blog/model/blog_event/blog_event_model.dart';

class BlockEventView extends StatelessWidget {
  final BlogEventModel model;
  const BlockEventView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return _buildListProduct();
  }

  Widget _buildListProduct() {
    return Obx(() {
      if (model.listTestimonial.isEmpty) {
        return const SizedBox();
      }
      return GridView.builder(
        itemCount: model.listTestimonial.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 66).copyWith(top: 60),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 54,
          mainAxisSpacing: 64,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => _buildEventCard(index),
      );
    });
  }

  Widget _buildEventCard(int index) {
    final event = model.listTestimonial[index];
    final List<List<Color>> gradientColors = [
      [const Color(0xFFFF8E25), const Color(0xFFFFB067)],
      [const Color(0xFF7C3AED), const Color(0xFF9F67FF)],
      [const Color(0xFF059669), const Color(0xFF34D399)],
      [const Color(0xFFDB2777), const Color(0xFFF472B6)],
    ];
    final cardGradient = gradientColors[index % gradientColors.length];
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => model.onTapEvent(event),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(event.userAvatar ?? 
                "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Ftestimonials%2Fcroitsant.webp?alt=media&token=eb776ca4-141a-4d44-98b0-796708f35add"),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: cardGradient[0].withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  cardGradient[0].withOpacity(0.4),
                  cardGradient[1].withOpacity(0.85),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEventDate(event.createDate, backgroundColor: cardGradient[0]),
                const SizedBox(height: 12),
                _buildEventTitle(event.userContent),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventDate(DateTime? date, {Color backgroundColor = const Color(0xFFFF8E25)}) {
    if (date == null) return const SizedBox();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        DateFormat('dd MMM yyyy', "vi").format(date),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildEventTitle(String? title) {
    return Text(
      title ?? '',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.3,
      ),
    );
  }
}
