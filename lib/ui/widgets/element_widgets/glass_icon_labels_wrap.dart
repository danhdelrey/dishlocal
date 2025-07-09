import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:flutter/material.dart';

class GlassIconLabelsWrap extends StatelessWidget {
  const GlassIconLabelsWrap({
    super.key,
    required this.iconLabels,
  });

  final List<CustomIconWithLabel> iconLabels;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderTop: true,
      borderLeft: true,
      borderRight: true,
      borderBottom: true,
      borderRadius: 12,
      borderWidth: 0.5,
      horizontalPadding: 5,
      verticalPadding: 2,
      blur: 0,
      backgroundColor: Colors.black,
      backgroundAlpha: 0.4,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        children: [...iconLabels],
      ),
    );
  }
}
