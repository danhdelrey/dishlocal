import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.amber, // Màu nền để dễ thấy
              child: AppIcons.app.toSvg(),
            ),
            Text(
              """Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a neque luctus lacus sagittis condimentum eu sit amet nulla. Nam sem ex, iaculis non cursus eget, ullamcorper in mi. Maecenas laoreet leo nec libero suscipit, quis venenatis odio varius. Quisque diam mi, imperdiet vitae porta sed, mollis commodo sem. Nulla convallis ante vitae feugiat blandit. Donec id posuere eros. Vivamus sed elit eget magna porttitor vehicula nec pulvinar elit. Aliquam elit libero, congue vitae eros vel, auctor gravida nisi. Sed nisi erat, cursus quis pellentesque non, pulvinar ac nisl.
    
    Pellentesque ut dignissim purus. Aenean mattis molestie iaculis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Quisque facilisis, libero nec imperdiet tincidunt, quam leo dictum diam, vel ultrices sapien leo vitae ex. In magna dolor, rhoncus id leo at, malesuada lobortis velit. Curabitur ut ligula pulvinar, hendrerit lacus eu, lacinia lacus. Nullam tincidunt molestie pellentesque. Maecenas et feugiat mi. Sed tempor accumsan erat vel dapibus. Donec leo urna, euismod at mi non, semper aliquet enim. Aliquam erat volutpat.
    
    Vestibulum hendrerit auctor massa, non maximus ante suscipit in. Etiam eu lorem nec nibh cursus rutrum nec efficitur diam. Vivamus rutrum magna porttitor mauris cursus vestibulum. Suspendisse potenti. Ut suscipit pellentesque elit, et convallis massa blandit finibus. Sed maximus mauris in tempus porta. Vivamus nec gravida augue. Praesent varius eget enim sed semper. Cras at erat dictum neque rhoncus placerat eget at ipsum. Sed pretium quam id efficitur dapibus. Nunc vel finibus turpis. Suspendisse a porta erat. Integer pulvinar malesuada erat, ac luctus dolor venenatis a.
    
    Proin iaculis arcu quis nisl vestibulum, et imperdiet justo posuere. Cras rhoncus vulputate dapibus. Sed et lacus at diam pellentesque laoreet. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer iaculis quam et ligula iaculis, in elementum urna suscipit. Nam vel sem eu ex tempor commodo. Fusce ut rutrum arcu. Nunc sit amet ex arcu. Quisque fringilla diam sit amet lacus sagittis, sit amet elementum lacus elementum. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce id nibh vel ante efficitur fermentum sit amet sed ligula.
    
    Mauris vitae vehicula mi. In quis mauris varius, efficitur turpis vitae, consectetur velit. Maecenas maximus sodales ex. Quisque ac ex vel ipsum facilisis faucibus et non sem. Vivamus faucibus odio turpis, vel efficitur sapien convallis non. Integer faucibus tincidunt tellus. Cras condimentum accumsan varius. Morbi massa est, dictum vitae commodo in, ultrices nec mauris. Donec nulla dui, posuere eget eleifend vitae, gravida eget tortor. Vivamus ac interdum risus.""",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
