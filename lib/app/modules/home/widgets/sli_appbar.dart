import 'package:audio_youtube/app/core/extension/num_extention.dart';
import 'package:flutter/material.dart';

import '../../../core/values/app_values.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Padding(
            padding: const EdgeInsets.only(
                left: AppValues.paddingLeft, right: AppValues.paddingRight),
            child: Row(
              children: [
                InkWell(
                  //Todo:  menu
                  onTap: () {},
                  child: const Icon(
                    Icons.menu,
                    size: 32,
                  ),
                ),
                12.w,
                Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 14),
                            hintText: 'Tìm kiếm',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            suffixIcon: const Icon(Icons.search)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
