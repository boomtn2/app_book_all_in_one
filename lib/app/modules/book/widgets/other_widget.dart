import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:flutter/widgets.dart';

import '../../../core/values/text_styles.dart';
import '../../../views/views/item_card_book_view.dart';

class OtherBookWidget extends StatelessWidget {
  const OtherBookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Đề xuất',
        style: headerStyle,
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            const ItemCardBookView(),
            10.w,
            const ItemCardBookView(),
            10.w,
            const ItemCardBookView(),
            10.w,
            const ItemCardBookView(),
          ],
        ),
      )
    ]);
  }
}
