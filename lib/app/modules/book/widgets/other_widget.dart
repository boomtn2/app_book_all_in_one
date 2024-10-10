import 'package:flutter/widgets.dart';
import '../../../core/values/text_styles.dart';

class OtherBookWidget extends StatelessWidget {
  const OtherBookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Đề xuất',
        style: headerStyle,
      ),
      const Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: [
            //
            // 10.w,
            // const ItemCardBookView(),
            // 10.w,
            // const ItemCardBookView(),
            // 10.w,
            // const ItemCardBookView(),
          ],
        ),
      )
    ]);
  }
}
