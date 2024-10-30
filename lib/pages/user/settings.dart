import 'package:aurora/components/common/custom_tile.dart';
import 'package:aurora/pages/user/settings/settings_about.dart';
import 'package:aurora/pages/user/settings/settings_layout.dart';
import 'package:aurora/pages/user/settings/settings_player.dart';
import 'package:aurora/pages/user/settings/settings_theme.dart';
import 'package:aurora/utils/sources/manga/extension_test/quickjs_testing.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Route _createSlideRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeInOut));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              IconlyBroken.arrow_left_2,
              size: 30,
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30),
          // CustomTile(
          //   icon: Icons.source,
          //   title: 'Sources',
          //   description: 'Switch Sources for Animes and Manga',
          //   onTap: () {
          //     Navigator.push(
          //         context, _createSlideRoute(const SourcesSettingPage()));
          //   },
          // ),
          CustomTile(
            icon: Icons.stairs_rounded,
            title: 'Layout',
            description: 'Change the app${"'"}s layout entirely',
            onTap: () {
              Navigator.push(context, _createSlideRoute(const LayoutPage()));
            },
          ),
          CustomTile(
            icon: Iconsax.play5,
            title: 'Player (Soon)',
            description: 'Change Video Player Settings',
            onTap: () {
              Navigator.push(
                  context, _createSlideRoute(const VideoPlayerSettings()));
            },
          ),
          CustomTile(
            icon: Iconsax.paintbucket5,
            title: 'Theme',
            description: 'Change the app theme',
            onTap: () {
              Navigator.push(context, _createSlideRoute(const ThemePage()));
            },
          ),
          CustomTile(
            icon: Icons.language,
            title: 'Language (Soon)',
            description: 'Change the app language',
            onTap: () {},
          ),
          CustomTile(
            icon: Iconsax.info_circle5,
            title: 'About',
            description: 'About this app',
            onTap: () {
              Navigator.push(context, _createSlideRoute(const AboutPage()));
            },
          ),
          CustomTile(
            icon: Iconsax.info_circle5,
            title: 'Fetch Data',
            description: 'Test',
            onTap: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const MangaSearchPage()));
            },
          ),
        ],
      ),
    );
  }
}
