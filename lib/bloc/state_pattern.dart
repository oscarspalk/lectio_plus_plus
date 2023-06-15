enum States { ready, loading, unready, error }

class StatePattern<T> {
  final T state;
  final States status;
  StatePattern(this.state, this.status);
}
