import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/core/network/connectivity/bloc/network_event.dart';
import 'package:minimart/src/core/network/connectivity/bloc/network_state.dart';
import 'package:minimart/src/core/network/connectivity/connectivity_service.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final ConnectivityService connectivityService;
  StreamSubscription? streamSubs;


  
  NetworkBloc({required this.connectivityService}) : super(NetworkInitial()) {
    on<NetworkStatusChanged>(onNetworkStatusChanged);
    streamSubs = connectivityService.getConnectionChanged.listen((isConnected) {
      add(NetworkStatusChanged(isConnected: isConnected));
    });

    on<NetwrokRefreshRequested>((event, emit) {
      log('network refresh event requested');
    });
  }

  FutureOr<void> onNetworkStatusChanged(event, emit) {
    if (event.isConnected) {
      emit(NetworkOnline());
    } else {
      emit(NetworkOffline());
    }
  }

  @override
  Future<void> close() {
    if (streamSubs != null) streamSubs?.cancel();
    return super.close();
  }
}
