# GN Homebrew tap

Builds GN from the pinned upstream commit at position 2643, with an optional HEAD build.

```sh
brew install gmerlino/gn/gn
```

The source build runs the upstream unit tests. `brew test` recreates their required executable/fixture layout; running the installed test binary directly does not locate its fixtures.

The older locally installed GN is not upgraded by organizing this repository.
