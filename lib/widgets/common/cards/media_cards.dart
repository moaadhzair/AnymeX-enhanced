import 'package:anymex/controllers/settings/methods.dart';
import 'package:anymex/utils/function.dart';
import 'package:anymex/widgets/common/cards/base_card.dart';
import 'package:anymex/widgets/custom_widgets/custom_text.dart';
import 'package:anymex/widgets/header.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class SaikouCard extends CarouselCard {
  final DataVariant variant;
  final bool isManga;

  const SaikouCard({
    super.key,
    required super.itemData,
    required super.tag,
    required this.variant,
    required this.isManga,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      constraints: BoxConstraints(maxWidth: isDesktop(context) ? 150 : 108),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardImage(context),
          if (shouldShowTitle()) ...[
            const SizedBox(height: 10),
            buildCardTitle(isDesktop(context)),
          ],
        ],
      ),
    );
  }

  Widget _buildCardImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.multiplyRoundness()),
      child: Stack(
        children: [
          Hero(
            tag: tag,
            child: NetworkSizedImage(
              imageUrl: itemData.poster!,
              radius: 12,
              height: isDesktop(context) ? 210 : 160,
              width: double.infinity,
            ),
          ),
          buildCardBadge(context, variant, isManga),
        ],
      ),
    );
  }
}

class ModernCard extends CarouselCard {
  final DataVariant variant;
  final bool isManga;

  const ModernCard({
    super.key,
    required super.itemData,
    required super.tag,
    required this.variant,
    required this.isManga,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      constraints: BoxConstraints(maxWidth: isDesktop(context) ? 150 : 108),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.multiplyRoundness()),
        child: Stack(
          children: [
            Hero(
              tag: tag,
              child: NetworkSizedImage(
                imageUrl: itemData.poster!,
                radius: 12,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            if (shouldShowTitle())
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: AnymexText(
                    text: itemData.title ?? '?',
                    maxLines: 2,
                    size: isDesktop(context) ? 14 : 12,
                    variant: TextVariant.semiBold,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                ),
              ),
            buildCardBadge(context, variant, isManga),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildCardBadge(
      BuildContext context, DataVariant variant, bool isManga) {
    final theme = Theme.of(context);

    return Positioned(
      top: 6,
      left: 6,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              getIconForVariant(itemData.extraData ?? '', variant, isManga),
              size: 16,
              color: theme.colorScheme.onPrimary,
            ),
            const SizedBox(width: 4),
            AnymexText(
              text: itemData.extraData ?? '',
              color: theme.colorScheme.onPrimary,
              size: 12,
              variant: TextVariant.bold,
            ),
          ],
        ),
      ),
    );
  }
}

class ExoticCard extends CarouselCard {
  final DataVariant variant;
  final bool isManga;

  const ExoticCard({
    super.key,
    required super.itemData,
    required super.tag,
    required this.variant,
    required this.isManga,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      constraints: BoxConstraints(maxWidth: isDesktop(context) ? 160 : 118),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.multiplyRoundness()),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.multiplyRoundness()),
              border: Border.all(
                color: primaryColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.multiplyRoundness()),
              child: Stack(
                children: [
                  Hero(
                    tag: tag,
                    child: NetworkSizedImage(
                      imageUrl: itemData.poster!,
                      radius: 10,
                      height: isDesktop(context) ? 210 : 160,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (shouldShowTitle()) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: AnymexText(
                text: itemData.title ?? '?',
                maxLines: 1,
                size: isDesktop(context) ? 14 : 12,
                variant: TextVariant.semiBold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            10.height(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    getIconForVariant(
                        itemData.extraData ?? '', variant, isManga),
                    size: 16,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 4),
                  AnymexText(
                    text: itemData.extraData ?? '',
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 12,
                    variant: TextVariant.bold,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class BlurCard extends CarouselCard {
  final DataVariant variant;
  final bool isManga;

  const BlurCard({
    super.key,
    required super.itemData,
    required super.tag,
    required this.variant,
    required this.isManga,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      constraints: BoxConstraints(maxWidth: isDesktop(context) ? 150 : 108),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.multiplyRoundness()),
        child: Stack(
          children: [
            Hero(
              tag: tag,
              child: NetworkSizedImage(
                imageUrl: itemData.poster!,
                radius: 12,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            if (shouldShowTitle()) ...[
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                    height: 50,
                    child: Blur(
                        blur: 5,
                        blurColor: Theme.of(context).colorScheme.primary,
                        colorOpacity: 0.3,
                        child: Container())),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: AnymexText(
                    text: itemData.title ?? '?',
                    maxLines: 2,
                    size: isDesktop(context) ? 14 : 12,
                    variant: TextVariant.semiBold,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            buildCardBadge(context, variant, isManga),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildCardBadge(
      BuildContext context, DataVariant variant, bool isManga) {
    final theme = Theme.of(context);

    return Positioned(
      top: 6,
      left: 6,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Blur(
                  blur: 5,
                  blurColor: Theme.of(context).colorScheme.surfaceContainer,
                  colorOpacity: 0.4,
                  child: Container()),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  getIconForVariant(itemData.extraData ?? '', variant, isManga),
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 4),
                AnymexText(
                  text: itemData.extraData ?? '',
                  color: theme.colorScheme.primary,
                  size: 12,
                  variant: TextVariant.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
