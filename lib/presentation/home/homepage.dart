import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone_with_flutter/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone_with_flutter/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone_with_flutter/core/configs/assets/app_images.dart';
import 'package:spotify_clone_with_flutter/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone_with_flutter/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_with_flutter/presentation/home/widget/new_songs.dart';
import 'package:spotify_clone_with_flutter/presentation/home/widget/play_list.dart';
import 'package:spotify_clone_with_flutter/presentation/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        action: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const ProfilePage(),
              ),
            );
          },
          icon: CircleAvatar(
            backgroundImage: NetworkImage(_auth.currentUser?.photoURL ??
                AppImages.profileImage), // Đường dẫn ảnh từ Firebase Auth
          ),
        ),
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 24,
          width: 24,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _homeTopCard(),
            _tab(),
            SizedBox(
              height: 240,
              child: TabBarView(
                controller: _tabController,
                children: [
                  const NewSongs(),
                  Container(),
                  Container(),
                  Container()
                ],
              ),
            ),
            const SizedBox(height: 10),
            const PlayList(),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homeTopCard),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 70),
                child: Image.asset(AppImages.homeArtist),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab() {
    return TabBar(
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      isScrollable: true,
      indicatorColor: AppColors.primaryColor,
      tabAlignment: TabAlignment.start,
      padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
      controller: _tabController,
      tabs: const [
        Text(
          'News',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        Text(
          'Videos',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        Text(
          'Artist',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        Text(
          'Podcads',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ],
    );
  }
}



// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();

//     _tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BasicAppBar(
//         hideBack: true,
//         action: IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (BuildContext context) => const ProfilePage(),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.person)),
//         title: SvgPicture.asset(
//           AppVectors.logo,
//           height: 24,
//           width: 24,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _homeTopCard(),
//             _tab(),
//             SizedBox(
//               height: 240,
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   const NewSongs(),
//                   Container(),
//                   Container(),
//                   Container()
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             const PlayList(),
//           ],
//         ),
//       ),
//     );
//   }
  

//   Widget _homeTopCard() {
//     return Center(
//       child: SizedBox(
//         height: 140,
//         child: Stack(
//           children: [
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: SvgPicture.asset(AppVectors.homeTopCard),
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 70),
//                 child: Image.asset(AppImages.homeArtist),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _tab() {
//     return TabBar(
//       labelColor: context.isDarkMode ? Colors.white : Colors.black,
//       isScrollable: true,
//       indicatorColor: AppColors.primaryColor,
//       tabAlignment: TabAlignment.start,
//       padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
//       controller: _tabController,
//       tabs: const [
//         Text(
//           'News',
//           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
//         ),
//         Text(
//           'Videos',
//           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
//         ),
//         Text(
//           'Artist',
//           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
//         ),
//         Text(
//           'Podcads',
//           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
//         ),
//       ],
//     );
//   }
// }