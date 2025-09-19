export function isValidLogPayload(payload) {
  return (
    Array.isArray(payload) &&
    payload.every(
      entry =>
        Array.isArray(entry) &&
        entry.length === 3 &&
        typeof entry[0] === 'string' &&
        typeof entry[1] === 'string' &&
        typeof entry[2] === 'string'
    )
  );
}
