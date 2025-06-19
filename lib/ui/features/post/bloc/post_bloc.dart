import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'post_event.dart';
part 'post_state.dart';
part 'post_bloc.freezed.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final _log = Logger('PostBloc');
  final PostRepository _postRepository;

  PostBloc(this._postRepository) : super(_Initial()) {
    on<PostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
