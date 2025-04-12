import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';

import '../../streams.dart';

class CustomAnimatedPaginationView extends StatelessWidget {
   CustomAnimatedPaginationView({super.key,
    required this.controller,
    required this.listKey,
    this.spacing,
    this.padding,
    required this.pageStream,
    required this.mapsListStream,
    required this.onBottomReach,
    required this.child,
    this.emptyChild,
    this.appBarChild,
    this.isReversed,
  }) : isGrid = false;
   CustomAnimatedPaginationView.grid({super.key,
    required this.controller,
    required this.listKey,
    this.spacing,
    this.padding,
    required this.pageStream,
    required this.mapsListStream,
    required this.onBottomReach,
    required this.child,
    this.emptyChild,
    this.appBarChild,
    this.isReversed,
  }) : isGrid = true;

  final bool? isReversed;
  final Widget Function(int page, List listMaps, int index) child;
  final Widget? emptyChild;
  final Widget? appBarChild;
  final Future Function(int currentPage,List currentMaps) onBottomReach;
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final ScrollController controller;
  final GlobalKey<SliverAnimatedListState> listKey;
  final IntStream pageStream;
  final ListStream mapsListStream;
  final ValueNotifier<bool> _hasReachedBottom = ValueNotifier<bool>(false);
   final ValueNotifier<bool> _isEmptyList = ValueNotifier<bool>(false);

  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
            stream: pageStream.intStream(),
            initialData: 1,
            builder: (context, pageSnapshot) {
              final currentPage = pageSnapshot.data;
              return StreamBuilder(
                  stream: mapsListStream.listStream(),
                  initialData: [],
                  builder: (context, snapshot) {
                    final currentMaps = snapshot.data;
                    if (isReversed == true) {
                      currentMaps.sort((a, b) {
                        DateTime dateA = DateTime.parse(a['taskCommentDate']);
                        DateTime dateB = DateTime.parse(b['taskCommentDate']);
                        return dateB.compareTo(dateA);
                      });
                    }


                    // Загружаем данные при первой загрузке
                    if (currentMaps.isEmpty && !_isEmptyList.value) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        onBottomReach(currentPage, currentMaps);
                        _isEmptyList.value = true;
                      });
                    } else if (!currentMaps.isEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _isEmptyList.value = false;
                      });
                    }

                    return Expanded(
                      child: LayoutBuilder(
                          builder: (context, constraints) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              if (isGrid == true) {
                                return GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
                                    itemBuilder: (context, i) {
                                      return GFShimmer(
                                        mainColor: Colors.grey[300]!,
                                        secondaryColor: Colors.grey[400]!,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      );
                                    }
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(color: Color(0xFF0065FF),),
                              );
                            } else if (snapshot.data.isEmpty && emptyChild != null) {
                              return Padding(
                                padding: padding != null ? padding! : EdgeInsets.zero,
                                child: Column(
                                  children: [

                                    if (appBarChild != null) appBarChild!,

                                    Expanded(child: emptyChild!)

                                  ],
                                ),
                              );
                            } else return Padding(
                              padding: padding != null ? padding! : EdgeInsets.zero,
                              child: NotificationListener<ScrollEndNotification>(
                                onNotification: (notification) {
                                  if (!_hasReachedBottom.value &&
                                      notification.metrics.pixels ==
                                          notification.metrics.maxScrollExtent) {
                                    _hasReachedBottom.value = true;
                                    onBottomReach(currentPage, currentMaps);
                                    Future.delayed(Duration(milliseconds: 500), () {
                                      _hasReachedBottom.value = false;
                                    });
                                  }
                                  return true;
                                },
                                child: CustomScrollView(
                                    reverse: isReversed ?? false,
                                    controller: controller,
                                    slivers: [

                                      if (appBarChild != null) SliverToBoxAdapter(
                                        child: appBarChild!,
                                      ),

                                      !isGrid ? SliverAnimatedList(
                                        key: listKey,
                                        initialItemCount: snapshot.data.length,
                                        itemBuilder: (context, i, animation) {
                                          return Padding(
                                            padding: i != 0 ? EdgeInsets.only(top: spacing??0) : EdgeInsets.zero,
                                            child: FadeTransition(
                                              opacity: animation,
                                              child: child(pageSnapshot.data,  snapshot.data, i),
                                            ),
                                          );
                                        },
                                      ) : SliverAnimatedGrid(
                                          key: listKey,
                                          initialItemCount: snapshot.data.length,
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
                                          itemBuilder: (context, i , animation) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child(pageSnapshot.data,  snapshot.data, i),
                                            );
                                          },
                                      ),

                                      SliverToBoxAdapter(
                                        child: SizedBox(height: 30,),
                                      )

                                    ]
                                ),
                              ),
                            );
                          }
                      ),
                    );
                  }
              );
            }
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _hasReachedBottom,
          builder: (context, hasReachedBottom, child) {
            if (hasReachedBottom) {
              Future.delayed(Duration(milliseconds: 500), () {
                _hasReachedBottom.value = false;
              });
            }
            return Container();
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isEmptyList,
          builder: (context, isEmptyList, child) {
            return Container();
          },
        ),
      ],
    );
  }
}
