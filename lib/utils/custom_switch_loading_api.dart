import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'basic_screen_imports.dart';

class CustomSwitchLoading extends StatelessWidget {
  const CustomSwitchLoading({
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: color,
        size: Dimensions.heightSize * 2.1,
      ),
    );
  }
}
