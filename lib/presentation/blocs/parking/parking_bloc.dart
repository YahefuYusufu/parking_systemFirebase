import 'package:equatable/equatable.dart';
import 'package:firebase_parking/domain/entities/parking_entity.dart';
import 'package:firebase_parking/domain/usecases/parking/create_parking_usecase.dart';
import 'package:firebase_parking/domain/usecases/parking/end_parking_usecase.dart' show EndParkingUseCase;
import 'package:firebase_parking/domain/usecases/parking/get_active_parking_usecase.dart';
import 'package:firebase_parking/domain/usecases/parking/get_parking_usecase.dart';
import 'package:firebase_parking/domain/usecases/parking/get_user_parking_usecase.dart';
import 'package:firebase_parking/presentation/blocs/notification/notification_bloc.dart';
import 'package:firebase_parking/presentation/blocs/notification/notification_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'parking_event.dart';
part 'parking_state.dart';

class ParkingBloc extends Bloc<ParkingEvent, ParkingState> {
  final CreateParkingUseCase createParking;
  final GetParkingUseCase getParking;
  final GetActiveParkingUseCase getActiveParking;
  final GetUserParkingUseCase getUserParking;
  final EndParkingUseCase endParking;
  final NotificationBloc notificationBloc;

  ParkingBloc({
    required this.createParking,
    required this.getParking,
    required this.getActiveParking,
    required this.getUserParking,
    required this.endParking,
    required this.notificationBloc,
  }) : super(ParkingInitial()) {
    on<CreateParkingEvent>(_onCreateParking);
    on<GetParkingEvent>(_onGetParking);
    on<GetActiveParkingEvent>(_onGetActiveParking);
    on<GetUserParkingEvent>(_onGetUserParking);
    on<EndParkingEvent>(_onEndParking);
  }

  Future<void> _onCreateParking(CreateParkingEvent event, Emitter<ParkingState> emit) async {
    emit(ParkingLoading());

    try {
      final parking = await createParking(event.vehicleId, event.parkingSpaceId);
      emit(ParkingCreated(parking));

      // Schedule parking reminder notifications
      if (parking.id != null && parking.vehicleRegistration != null) {
        print("🔔 Scheduling parking reminders for ${parking.vehicleRegistration}");

        notificationBloc.add(ScheduleParkingReminders(parkingId: parking.id!, vehicleRegistration: parking.vehicleRegistration!, parkingStartTime: parking.startedAt));

        // Show immediate "parking started" notification
        if (parking.parkingSpaceNumber != null) {
          notificationBloc.add(
            ShowParkingStartedNotification(parkingId: parking.id!, vehicleRegistration: parking.vehicleRegistration!, parkingSpaceNumber: parking.parkingSpaceNumber!),
          );
        }
      }
    } catch (e) {
      emit(ParkingError(e.toString()));
    }
  }

  Future<void> _onGetParking(GetParkingEvent event, Emitter<ParkingState> emit) async {
    emit(ParkingLoading());

    try {
      final parking = await getParking(event.parkingId);

      if (parking != null) {
        emit(ParkingLoaded(parking));
      } else {
        emit(const ParkingError('Parking not found'));
      }
    } catch (e) {
      emit(ParkingError(e.toString()));
    }
  }

  Future<void> _onGetActiveParking(GetActiveParkingEvent event, Emitter<ParkingState> emit) async {
    emit(ParkingLoading());

    try {
      final parkingList = await getActiveParking();
      emit(ParkingListLoaded(parkingList));
    } catch (e) {
      emit(ParkingError(e.toString()));
    }
  }

  Future<void> _onGetUserParking(GetUserParkingEvent event, Emitter<ParkingState> emit) async {
    emit(ParkingLoading());

    try {
      final parkingList = await getUserParking(event.userId);
      emit(ParkingListLoaded(parkingList));
    } catch (e) {
      emit(ParkingError(e.toString()));
    }
  }

  Future<void> _onEndParking(EndParkingEvent event, Emitter<ParkingState> emit) async {
    emit(ParkingLoading());

    try {
      final updatedParking = await endParking(event.parkingId);
      emit(ParkingEnded(updatedParking));

      // Cancel all scheduled reminders for this parking session
      print("🗑️ Cancelling parking notifications for ${event.parkingId}");
      notificationBloc.add(CancelParkingNotifications(event.parkingId));

      // Show "parking ended" notification with duration and cost
      if (updatedParking.vehicleRegistration != null) {
        final duration = updatedParking.duration;
        final cost = updatedParking.calculateFee();

        notificationBloc.add(ShowParkingEndedNotification(parkingId: event.parkingId, vehicleRegistration: updatedParking.vehicleRegistration!, duration: duration, cost: cost));
      }
    } catch (e) {
      emit(ParkingError(e.toString()));
    }
  }
}
