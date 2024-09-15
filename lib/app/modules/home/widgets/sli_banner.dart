// import 'package:audio_youtube/app/modules/home/widgets/title.dart';
// import 'package:card_swiper/card_swiper.dart';
// import 'package:flutter/material.dart';

// import '../../../core/values/app_values.dart';
// import '../../../core/values/text_styles.dart';

// class SliverBannerView extends StatelessWidget {
//   const SliverBannerView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Padding(
//         padding: const EdgeInsets.only(
//             left: AppValues.paddingLeft, right: AppValues.paddingRight),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const TitleView(
//                   title: "Chọn lọc",
//                 ),
//                 Text(
//                   'Xem thêm',
//                   style: fontStyteLoadMore,
//                 )
//               ],
//             ),
//             SizedBox(
//               width: double.infinity,
//               height: 120,
//               child: Swiper(
//                 itemBuilder: (BuildContext context, int index) {
//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(6),
//                     child: Image.network(
//                       'https://i.ytimg.com/vi/KPssR-ReIds/hqdefault.jpg',
//                       fit: BoxFit.fill,
//                     ),
//                   );
//                 },
//                 itemCount: 10,
//                 viewportFraction: 0.6,
//                 scale: 0.8,
//                 autoplayDelay: 4000,
//                 autoplay: true,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
