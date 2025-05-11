import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rfw_banner_event.dart';
part 'rfw_banner_state.dart';

class RfwBannerBloc extends Bloc<RfwBannerEvent, RfwBannerState> {
  RfwBannerBloc() : super(RfwBannerInitial()) {
    on<RfwBannerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
