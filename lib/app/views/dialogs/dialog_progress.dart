import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:audio_youtube/app/core/values/text_styles.dart';
import 'package:audio_youtube/app/core/widget/loading.dart';
import 'package:flutter/material.dart';

class DialogProgress extends StatelessWidget {
  const DialogProgress(
      {super.key, required this.notifier, required this.callBack});
  final ValueNotifier notifier;
  final Function callBack;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.black45,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Loading(),
              10.h,
              ValueListenableBuilder(
                valueListenable: notifier,
                builder: (context, value, child) {
                  return RichText(
                      text: TextSpan(
                          text: 'Đang tải ',
                          style:
                              afaca.s14.copyWith(fontWeight: FontWeight.w400),
                          children: [
                        TextSpan(
                            text: '$value',
                            style: afaca.s16
                                .copyWith(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: ' / 50 tập',
                            style: afaca.s16
                                .copyWith(fontWeight: FontWeight.w400)),
                      ]));
                },
              ),
              20.h,
              TextButton(
                  onPressed: () {
                    callBack();
                  },
                  child: Text(
                    'Huỷ tải',
                    style: afaca.copyWith(color: Colors.red),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
