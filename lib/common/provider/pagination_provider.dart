import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_delivery_app/common/model/cursor_pagination_model.dart';
import 'package:flutter_delivery_app/common/model/model_with_id.dart';
import 'package:flutter_delivery_app/common/model/pagination_params.dart';
import 'package:flutter_delivery_app/common/repository/base_pagination_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class _PaginationInfo {
  final int fetchCount;
  final bool fetchMore;
  final bool forceRefetch;

  _PaginationInfo({
    this.fetchCount = 20,
    this.fetchMore = false,
    this.forceRefetch = false,
  });
}

// 제너릭 타입에 'extends' 를 통한 상속만 가능하다
class PaginationProvider<T extends IModelWithId,
        U extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;

  final paginationThrottle = Throttle(
    const Duration(seconds: 5),
    initialValue: _PaginationInfo(),
    checkEquality: false, // 함수 실행 시 넣는 값이 똑같을 때 재 실행 여부.
  );

  PaginationProvider({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();

    // .setValue 실행 시 .listen 이 실행된다.
    paginationThrottle.values.listen(
      (state) {
        _throttledPagination(state);
      },
    );
  }

  Future<void> paginate({
    // params
    // # fetchMore
    // 추가로 데이터 더 가져오기
    // rue - 추가로 데이터 더 가져옴
    // false - 새로 고침 (첫번째 페이지 데이터) (현재 상태를 덮어 씌움)
    // ----------------------------------------------------------
    // # forceRefetch
    // 강제로 다시 로딩하기
    // true - CursorPaginationLoading()

    // 5가지 Issue
    // State 의 상태
    // 1) CursorPagination - 정상적으로 데이터가 있음.
    // 2) CursorPaginationLoading - 데이터 로딩 중. (캐시 없음)
    // 3) CursorPaginationError - 에러 존재.
    // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터 가져올 떄.
    // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 요청 받았을 떄.

    // 바로 반환하는 상황
    // 1) hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 가지고 있다면)
    // 2) 로딩 중 - fetchMore : true
    //    fetchMore 가 아닐 때 - 새로고침의 의도가 있을 수 있다.

    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    paginationThrottle.setValue(
      _PaginationInfo(
        fetchMore: fetchMore,
        fetchCount: fetchCount,
        forceRefetch: forceRefetch,
      ),
    );
  }

  void _throttledPagination(
    _PaginationInfo info,
  ) async {
    final int fetchCount = info.fetchCount;
    final bool fetchMore = info.fetchMore;
    final bool forceRefetch = info.forceRefetch;

    try {
      // 바로 반환하는 상황 ---------------------------------------------------------
      if (state is CursorPagination && !forceRefetch) {
        // 1) hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 가지고 있다면)
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      // 2) 로딩 중 - fetchMore : true
      // 세가지 로딩 상태에 대한 나열.
      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }
      // -------------------------------------------------------------------------

      // PaginationParams 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore
      // 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      }
      // 데이터를 처음부터 가져오는 상황
      else {
        // 만약에 데이터가 있는 상황이라면
        // 기존 데이터를 보존한 채로 Fetch (API 요청) 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;

          state = CursorPaginationRefetching<T>(
            meta: pState.meta,
            data: pState.data,
          );
        }
        // 나머지 상황 (데이터 유지가 필요 없는 상황)
        else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;

        // 기존 데이터에 새로운 데이터 추가.
        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      } else {
        state = resp;
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(
        message: '데이터를 가져오지 못했습니다.',
      );
    }
  }
}
