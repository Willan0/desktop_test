import 'package:flutter/cupertino.dart';
import 'package:desktop_test/constant/dimen.dart';

class PersistentHeaderDelegateWidget extends SliverPersistentHeaderDelegate {
  Widget child;
  PersistentHeaderDelegateWidget(this.child);
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      child;

  @override
  double get maxExtent => kAs50x;

  @override
  double get minExtent => kAs50x;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
