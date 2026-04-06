# Changelog

## [0.2.3] - 2026-04-06

### Changed

- README: clarify that the bridge relays raw LoRa packets and works with any
  protocol (Meshtastic, MeshCore, etc.) simultaneously.

## [0.2.2] - 2026-04-06

### Fixed

- TUI now fits in 80-column terminals (was 86).

## [0.2.1] - 2026-04-06

### Fixed

- CI: removed stale sibling-clone step, added `libudev-dev` dependency,
  upgraded `actions/checkout` to v5 (Node.js 24).

## [0.2.0] - 2026-04-06

### Added

- Auto-detect connection mode: when no `port` is configured, the bridge now
  tries the mux daemon first and falls back to direct USB serial
  (`find_port()`) if the mux is unavailable. Previously it would retry the mux
  forever.

### Changed

- Config negotiation on direct serial connections now pushes `SetConfig` with
  the desired radio config when it differs from the dongle's current config.
  On mux connections, the existing behavior (accept the mux's config) is
  unchanged.

## [0.1.0] - 2026-04-06

Initial release.
