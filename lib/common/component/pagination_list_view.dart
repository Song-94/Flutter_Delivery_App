import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_delivery_app/common/model/model_with_id.dart';
import 'package:flutter_delivery_app/common/provider/pagination_provider.dart';
import 'package:flutter_delivery_app/common/utils/pagination_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
  BuildContext context,
  int index,
  T model,
);

// <T extends aClass>
// 제너릭 된 T는 aClass 를 상속하고 있어야 가능하다.

class PaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  // 조건
  // StateNotifier : PaginationProvider
  // state : CursorPaginationBase

  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;

  final PaginationWidgetBuilder<T> itemBuilder;

  const PaginationListView({
    required this.provider,
    required this.itemBuilder,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<PaginationListView> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId>
    extends ConsumerState<PaginationListView> {
  final ScrollController controller = ScrollController();

  void listener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }


  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    // 완전 처음 로딩
    if (state is CursorPaginationLoading) {
      print('state is CursorPaginationLoading');
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (state is CursorPaginationError) {
      print('state is CursorPaginationError');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              ref.read((widget.provider.notifier)).paginate(forceRefetch: true);
            },
            child: const Text('다시시도'),
          ),
        ],
      );
    }

    // 다른 상황들
    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching

    final cp = state as CursorPagination<T>;

    print('state is CursorPagination');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length + 1, // 끝에 로딩 이미지를 위한 + 1
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Center(
                child: cp is CursorPaginationFetchingMore
                    ? const CircularProgressIndicator()
                    : const Text('마지막 데이터 입니다 ㅜㅜ.'),
              ),
            );
          }

          final pItem = cp.data[index];

          return widget.itemBuilder(
            context,
            index,
            pItem,
          );
        },

        separatorBuilder: (_, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
