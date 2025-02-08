// ignore_for_file: prefer_const_constructors

import 'package:anymex/controllers/service_handler/service_handler.dart';
import 'package:anymex/models/Media/media.dart';
import 'package:anymex/screens/home_page.dart';
import 'package:anymex/utils/fallback/fallback_anime.dart';
import 'package:anymex/utils/fallback/fallback_manga.dart';
import 'package:anymex/widgets/helper/platform_builder.dart';
import 'package:anymex/widgets/minor_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimeStats extends StatelessWidget {
  final Media data;
  final String countdown;
  const AnimeStats({
    super.key,
    required this.data,
    required this.countdown,
  });

  @override
  Widget build(BuildContext context) {
    final serviceHandler = Get.find<ServiceHandler>();
    final isSimkl = serviceHandler.serviceType.value == ServicesType.simkl;
    final covers = (isSimkl
            ? [
                ...serviceHandler.simklService.trendingMovies,
                ...serviceHandler.simklService.trendingSeries
              ]
            : [
                ...serviceHandler.anilistService.trendingAnimes,
                ...serviceHandler.anilistService.trendingMangas,
                ...trendingAnimes,
                ...trendingMangas
              ])
        .where((e) => e.cover != null && (e.cover?.isNotEmpty ?? false))
        .toList();
    final isDesktop = MediaQuery.of(context).size.width > 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (countdown != '0')
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnymexText(
                  text:
                      "EPISODE ${data.nextAiringEpisode?.episode} WILL BE RELEASED IN",
                  size: 14,
                  variant: TextVariant.bold,
                  color: Colors.grey,
                ),
                const SizedBox(height: 5),
                AnymexText(
                  text: countdown,
                  size: 20,
                  variant: TextVariant.bold,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        const AnymexText(
          text: "Statistics",
          variant: TextVariant.bold,
          size: 17,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              StateItem(label: "Japanese", value: data.romajiTitle),
              StateItem(label: "Type", value: data.type),
              StateItem(label: "Rating", value: '${data.rating}/10'),
              StateItem(label: "Popularity", value: data.popularity),
              StateItem(label: "Season", value: data.season),
              StateItem(label: "Format", value: data.format),
              StateItem(label: "Status", value: data.status),
              StateItem(label: "Duration", value: data.duration),
              StateItem(label: "Total Episodes", value: data.totalEpisodes),
              StateItem(label: "Premiered", value: data.premiered),
              StateItem(label: "Studios", value: data.studios?.first ?? ''),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const AnymexText(
          text: "Synopsis",
          variant: TextVariant.bold,
          size: 17,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: AnymexText(
            text: data.description,
            variant: TextVariant.semiBold,
            size: 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
            maxLines: 100,
          ),
        ),
        const SizedBox(height: 10),
        const AnymexText(
          text: "Genres",
          variant: TextVariant.bold,
          size: 17,
        ),
        GridView.builder(
          padding: EdgeInsets.only(top: 15),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.genres.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisCount: getResponsiveCrossAxisCount(context,
                  baseColumns: 2, maxColumns: 4),
              mainAxisSpacing: 10,
              mainAxisExtent: isDesktop ? 80 : 60,
              crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            final e = data.genres[index];
            return ImageButton(
                buttonText: e,
                height: 80,
                width: 1000,
                onPressed: () {},
                backgroundImage: covers[index].cover!);
          },
        ),
      ],
    );
  }
}

class StateItem extends StatelessWidget {
  final String label;
  final String value;
  const StateItem({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnymexText(
          text: label,
          variant: TextVariant.semiBold,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
        ),
        Expanded(
          child: AnymexText(
            text: value,
            variant: TextVariant.semiBold,
            color: Theme.of(context).colorScheme.primary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
