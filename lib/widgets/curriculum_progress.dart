import 'package:flutter/material.dart';
import '../providers/user_data.dart';
import 'rounded_border.dart';

class CurriculumProgressView extends StatelessWidget {
  const CurriculumProgressView({
    Key? key,
    required this.userProvider,
  }) : super(key: key);

  final UserDataProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      radius: 16.0,
      //height: 146.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "활동 기간", // debug
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w300,
                                ),
                      ),
                      SizedBox(width: 9.0),
                    ],
                  ),
                  Text(
                    "${userProvider.user!.curriculum.period}학기", // debug
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Color(0xFFABABAB),
                          fontSize: 11.0,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
