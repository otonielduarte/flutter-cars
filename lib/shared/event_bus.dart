import 'package:provider/provider.dart';

import 'package:cars/shared/generic_bloc.dart';

class Event {
  String? event;
  Event({
    this.event,
  });
}

class EventBus extends GenericBloc<Event> {
  sendEvent(Event event) {
    add(event);
  }

  static EventBus get(context) {
    return Provider.of<EventBus>(context, listen: false);
  }
}
