import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loto/page/shopping/blog/model/blog_event/blog_event_model.dart';

class BlockEventViewMobile extends StatelessWidget {
  final BlogEventModel model;
  const BlockEventViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        _buildListProduct(width),
        const SizedBox(height: 20),
        _buildPagination(),
      ],
    );
  }

  Widget _buildListProduct(double width) {
    final itemCount = width <= 600 ? 2 : 3;
    final itemsPerPage = itemCount * 2;
    
    return Obx(() {
      if (model.listTestimonial.isEmpty) {
        return const SizedBox();
      }

      final int startIndex = model.currentPage.value * itemsPerPage;
      final int endIndex = (startIndex + itemsPerPage) > model.listTestimonial.length 
          ? model.listTestimonial.length 
          : startIndex + itemsPerPage;
      
      return GridView.builder(
        itemCount: endIndex - startIndex,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 30, bottom: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemCount,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => _buildEventCard(index + startIndex),
      );
    });
  }

  Widget _buildPagination() {
    return Obx(() {
      final itemCount = MediaQuery.of(Get.context!).size.width <= 600 ? 4 : 6;
      final int totalPages = (model.listTestimonial.length / itemCount).ceil();
      if (totalPages <= 1) return const SizedBox();

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: model.currentPage.value > 0 
                ? () => model.currentPage.value-- 
                : null,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: model.currentPage.value > 0 
                  ? const Color(0xFFFF8E25) 
                  : Colors.grey,
            ),
          ),
          ...List.generate(totalPages, (index) => 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: InkWell(
                onTap: () => model.currentPage.value = index,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: model.currentPage.value == index
                        ? const LinearGradient(
                            colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
                          )
                        : null,
                    border: model.currentPage.value != index
                        ? Border.all(color: const Color(0xFFFF8E25))
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        color: model.currentPage.value == index
                            ? Colors.white
                            : const Color(0xFFFF8E25),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: model.currentPage.value < totalPages - 1 
                ? () => model.currentPage.value++ 
                : null,
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: model.currentPage.value < totalPages - 1 
                  ? const Color(0xFFFF8E25) 
                  : Colors.grey,
            ),
          ),
        ],
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
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(event.userAvatar ?? 
                "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Ftestimonials%2Fcroitsant.webp?alt=media&token=eb776ca4-141a-4d44-98b0-796708f35add"),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: cardGradient[0].withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
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
                const SizedBox(height: 8),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        DateFormat('dd MMM yyyy', "vi").format(date),
        style: const TextStyle(
          fontSize: 12,
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
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.3,
      ),
    );
  }
}
