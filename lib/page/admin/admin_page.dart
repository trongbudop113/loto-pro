import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/admin/admin_controller.dart';
import 'package:loto/page/admin/mixin/appbar_mixin.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/src/style_resource.dart';

class AdminPage extends GetView<AdminController> with AppbarMixin {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4E6F1),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: boxConstraints,
          child: LayoutBuilder(builder: (context, constraint) {
            return _buildBody(context, constraint);
          }),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraint){
    return Column(
      children: [
        buildAppBar(context, constraint, title: "Quản trị hệ thống"),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorResource.color_background_light,
                  ColorResource.color_background_light.withOpacity(0.8),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildResponsiveGrid(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double childAspectRatio;
        
        // Responsive layout based on screen width
        if (constraints.maxWidth > 1200) {
          // Web layout
          crossAxisCount = 4;
          childAspectRatio = 1.0;
        } else if (constraints.maxWidth > 600) {
          // Tablet layout
          crossAxisCount = 3;
          childAspectRatio = 1.0;
        } else {
          // Mobile layout
          crossAxisCount = 2;
          childAspectRatio = 1.0;
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: controller.adminMenuItems.length,
          itemBuilder: (context, index) {
            final item = controller.adminMenuItems[index];
            return _buildAdminCard(context, item);
          },
        );
      },
    );
  }

  Widget _buildAdminCard(BuildContext context, AdminMenuItem item) {
    return Card(
      elevation: 6,
      shadowColor: ColorResource.color_main_light.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: ColorResource.color_white_light,
      child: InkWell(
        onTap: () => controller.onMenuItemTap(item),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorResource.color_white_light,
                ColorResource.color_white_light.withOpacity(0.9),
              ],
            ),
            border: Border.all(
              color: item.color.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: item.color.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  item.icon,
                  size: 40,
                  color: item.color,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                item.title,
                style: TextStyleResource.textStyleCaption(context).copyWith(
                  color: ColorResource.color_black_light,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                item.subtitle,
                style: TextStyleResource.textStyleGrey(context).copyWith(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminMenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;

  AdminMenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
  });
}