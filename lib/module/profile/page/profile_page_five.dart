import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/module/profile/cubit/profile_cubit/profile_cubit.dart';
import 'package:orca/module/profile/page/profile_page_six.dart';
import 'package:orca/utils/extensions/extended_context.dart';

import '../../../config/routes/nav_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../ui/button/primary_button.dart';
import '../../../ui/widget/loading_widget.dart';
import '../../authentication/model/sign_up_model.dart';
import '../../authentication/repository/user_account_repository.dart';
import '../model/profile_model.dart';
import '../widget/interest_list_widget.dart';

class ProfilePageFive extends StatefulWidget {


  const ProfilePageFive({super.key,});

  @override
  State<ProfilePageFive> createState() => _ProfilePageFiveState();
}

class _ProfilePageFiveState extends State<ProfilePageFive> {
  List<String> interestList = [
    '🎤 Singing',
    '💃 Dancing',
    '💻 Coding',
    '🎮 Playing Video Games',
    '📺 Watching TV Shows',
    '🎸 Playing Music',
    '🎨 Drawing',
    '📚 Reading',
    '🏃‍♂️ Running',
    '🏊‍♀️ Swimming',
    '🌍 Traveling',
    '🍳 Cooking',
    '🧘‍♀️ Yoga',
    '🎥 Filmmaking',
    '🖥️ Gaming',
    '🛶 Kayaking',
    '🚴‍♂️ Cycling',
    '🌱 Gardening',
    '🎉 Partying',
    '📸 Photography',
    '🎲 Playing Board Games',
    '🤖 Robotics',
    '📝 Writing',
    '🧩 Solving Puzzles',
    '🎼 Composing Music',
    '🥋 Practicing Martial Arts',
    '👨‍🍳 Baking',
    '💌 Crafting',
    '🚀 Astronomy',
    '🎤 Karaoke',
    '🧗‍♀️ Rock Climbing',
    '🎧 Listening to Music',
    '🌌 Stargazing',
    '📖 Creative Writing',
    '🧵 Sewing',
    '🎻 Playing the Violin',
    '🛹 Skateboarding',
    '🐾 Volunteering at Animal Shelters',
    '🌊 Surfing',
    '🕺 Hip-Hop Dance',
    '🎯 Archery',
    '🪴 Indoor Plant Care',
    '🎺 Playing Brass Instruments',
    '🕹️ Playing Retro Video Games',
    '🎤 Open Mic Nights',
    '🥗 Healthy Cooking',
    '🎨 Digital Art',
    '🌼 Flower Arranging',
    '🎭 Acting in Theater',
    '🍰 Cake Decorating',
    '🧘‍♂️ Meditation',
    '🎮 eSports Competitions',
    '🏕️ Camping',
    '📚 Book Club Discussions',
    '🖌️ Watercolor Painting',
    '🎲 Magic Tricks',
    '🍷 Wine Tasting',
    '🎃 Halloween Decorating',
    '🔭 Telescope Observing',
    '📜 Calligraphy',
    '📻 Podcasting',
    '🚢 Cruising',
    '🧩 Escape Rooms',
    '🥁 Drumming',
    '🚴‍♀️ Mountain Biking',
    '🪄 Magic: The Gathering',
    '🖥️ Building Computers',
    '🍕 Food Truck Exploration',
    '🎸 Jam Sessions',
    '🐶 Dog Training',
    '💪 Weightlifting',
    '🧑‍🌾 Urban Farming',
    '🚨 First Aid Training',
    '🏖️ Beach Volleyball',
    '🏛️ Visiting Museums',
    '🌉 Urban Exploration',
    '📅 Event Planning',
    '🚀 Space Exploration',
    '🏇 Horseback Riding',
    '🎨 Street Art',
    '🔥 Fire Dancing',
    '🪴 Bonsai Tree Cultivation',
    '🎻 Folk Music Festivals',
    '🎮 VR Gaming',
    '🌍 Cultural Festivals',
    '🥧 Pie Baking',
    '🐟 Fishing',
    '🎸 Music Festivals',
    '🎹 Playing Piano',
    '🍵 Tea Brewing',
    '🏌️‍♂️ Golfing',
    '🍂 Leaf Peeping',
    '🎸 Learning New Instruments',
    '🔥 Cooking on a Grill',
    '🌪️ Storm Chasing',
    '🏆 Competing in Sports',
    '🕵️‍♀️ Mystery Novels',
    '🎿 Skiing',
    '🎉 Organizing Community Events',
    '🌍 Environmental Activism'
  ];
  List<String> selectedIntersets = [];
  final userRepo =
  UserAccountRepository(storageService: sl(), sessionRepository: sl());
  String currentPage = '5';

  @override
  Widget build(BuildContext context) {
    SignUpModel user = userRepo.getUserFromDb();
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("What are you into?",
                    style: context.textTheme.headlineLarge!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 25)),
                const Text('You like what you like. Now,let everyone Know'),
                const SizedBox(
                  height: 5,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                InterestListWidget(
                  interestList: interestList,
                  onSelectedInterests: (value) {
                    setState(() {
                      if (selectedIntersets.contains(value)) {
                        selectedIntersets.remove(value);
                      } else {
                        selectedIntersets.add(value);
                      }
                    });
                  },
                  selectedInterest: selectedIntersets,
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            )),
        floatingActionButton: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state.profileStatus == ProfileStatus.success &&
                currentPage == '5') {
              NavRouter.pushReplacement(
                  context,
                  ProfilePageSix(
                  ));
            }
          },
          builder: (context, state) {
            return PrimaryButton(
                hMargin: 20,
                onPressed: () {
                  if (selectedIntersets.isNotEmpty) {
                    if(selectedIntersets.length>6){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('You can select maximum six Interest')));
                    }else
                      {
                        context.read<ProfileCubit>().setList(
                            user.id!, 'intersets', selectedIntersets);
                        context
                            .read<ProfileCubit>()
                            .setProfileStatus(user.id!, '5');
                      }
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('not selected')));
                  }
                },
                title: 'Next');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
