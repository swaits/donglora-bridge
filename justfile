set shell := ["bash", "-c"]

default: build

[private]
_ensure_tools:
    @mise trust --yes . 2>/dev/null; mise install --quiet

# Run the bridge (TUI mode)
run *args: _ensure_tools
    cargo run --release -- {{args}}

# Run in headless mode
run-headless *args: _ensure_tools
    cargo run --release -- --log-only {{args}}

# Run the config wizard
config: _ensure_tools
    cargo run --release -- config

# Run all checks (fmt, clippy, test, audit)
check: fmt-check clippy test audit

# Format code
fmt: _ensure_tools
    cargo fmt

# Check formatting without changing files
fmt-check: _ensure_tools
    cargo fmt --check

# Lint with clippy
clippy: _ensure_tools
    cargo clippy --all-targets -- -D warnings

# Run all tests
test: test-unit

# Normal unit tests
test-unit: _ensure_tools
    cargo nextest run

# Mutation testing
test-mutants *args: _ensure_tools
    cargo mutants {{args}}

# Fuzz a target (requires nightly)
test-fuzz TARGET="fuzz_gossip_frame_decode" DURATION="60": _ensure_tools
    cargo +nightly fuzz run {{TARGET}} -- -max_total_time={{DURATION}}

# Security + license audit
audit: _ensure_tools
    cargo deny check

# Build release binary
build: _ensure_tools
    cargo build --release

# Generate docs
doc: _ensure_tools
    cargo doc --no-deps --open

# Check for outdated dependencies
outdated: _ensure_tools
    cargo outdated

# Clean build artifacts
clean:
    cargo clean
