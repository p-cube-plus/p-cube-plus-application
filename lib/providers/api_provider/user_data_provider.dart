import 'package:p_cube_plus_application/models/caution.dart';
import 'package:p_cube_plus_application/models/curriculum.dart';
import 'package:p_cube_plus_application/models/member.dart';
import 'package:p_cube_plus_application/models/project.dart';
import 'package:p_cube_plus_application/models/promotion_progress.dart';
import 'package:p_cube_plus_application/models/seminar.dart';
import 'package:p_cube_plus_application/models/user.dart';
import 'package:p_cube_plus_application/providers/api_provider/base/provider_base.dart';
import 'package:p_cube_plus_application/services/user_api.dart';

class UserDataProvider extends ApiProviderBase<User> {
  UserDataProvider() : super(client: new UserProfileApi());

  // mode = 0(경고), 1(주의)
  double totalCaution(int type, {int sign = 1}) {
    double ret = 0;

    for (int i = 0; i < data.cautions.length; i++) {
      Caution caution = data.cautions[i];
      if (type != 2 && type != caution.type) continue;
      if (sign != caution.amount.sign) continue;

      ret += (2 - caution.type) / 2 * caution.amount;
    }

    return ret.abs();
  }

  User _getDummyData() => User(
        id: 3,
        level: "정회원",
        name: "조승빈",
        profileImage:
            null, //"https://cdn.discordapp.com/avatars/264788350227972097/ba95f75e90872ba95c65f1d89f7f0148.webp",
        partIndex: 1,
        projects: <Project>[
          Project(
            id: 0,
            type: 0,
            name: "PCube+",
            status: 2,
            startDate: DateTime(2022, 05, 27),
            endDate: DateTime(2023, 01, 31),
            members: <Member>[
              Member(
                  id: 0,
                  isSigned: true,
                  name: "오창한",
                  level: 1,
                  partIdx: 1,
                  profileImage: null),
              Member(
                  id: 1,
                  isSigned: true,
                  name: "권오민",
                  level: 1,
                  partIdx: 1,
                  profileImage: null),
              Member(
                  id: 2,
                  isSigned: true,
                  name: "신혜민",
                  level: 1,
                  partIdx: 2,
                  profileImage: null),
              Member(
                  id: 3,
                  isSigned: true,
                  name: "조승빈",
                  level: 1,
                  partIdx: 1,
                  profileImage: null),
              Member(
                  id: 3,
                  isSigned: true,
                  name: "정성희",
                  level: 1,
                  partIdx: 1,
                  profileImage: null),
            ],
            pm: Member(
                id: 0,
                isSigned: true,
                name: "오창한",
                level: 1,
                partIdx: 1,
                profileImage: null),
            platforms: <String>["Android"],
            graphic: "2D",
            isFindingMember: false,
            isAbleInquiry: true,
          ),
        ],
        cautions: <Caution>[
          Caution(
            id: 0,
            type: 0,
            amount: 1,
            description: "경고 부여 사유~~~~",
            date: DateTime(2022, 05, 27),
          ),
          Caution(
            id: 1,
            type: 1,
            amount: 1,
            description: "주의 부여 사유~~",
            date: DateTime(2022, 05, 27),
          )
        ],
        seminars: <Seminar>[
          Seminar(
            id: 3,
            type: 0,
            description: "",
            date: DateTime(2020, 05, 27),
          ),
          Seminar(
            id: 4,
            type: 1,
            description: "",
            date: DateTime(2021, 05, 28),
          ),
          Seminar(
            id: 5,
            type: 0,
            description: "",
            date: DateTime(2022, 05, 29),
          ),
        ],
        promotionProgress: PromotionProgress(
          semester: false,
          curriculum: Curriculum(
            completed: false,
            name: "유니티 커리큘럼",
            startDate: DateTime(2022, 07, 16),
            endDate: DateTime(2022, 08, 05),
          ),
          progress: 0.6,
          projectAttended: false,
          projectType: 1,
          workshopComplete: true,
          workshopCount: 2,
          vote: false,
        ),
      );
}
