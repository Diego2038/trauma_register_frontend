class Optional<T> {
  final bool isPresent;
  final T? value;

  const Optional.absent()
      : isPresent = false,
        value = null;

  const Optional.of(this.value) : isPresent = true;
}
