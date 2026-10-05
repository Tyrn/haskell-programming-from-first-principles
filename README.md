# Haskell Programming from First Principles

This is a fork from [this](https://github.com/BoeingX/haskell-programming-from-first-principles)
excellent project.

What has changed:

- The ecosystem moved from _Haskell 2010_ to _GHC2024_

- Stack dropped in favor of Cabal

- The necessary
  [source changes](https://github.com/Tyrn/haskell-programming-from-first-principles/commit/2ee97a06d7a3360a00db5fcedd2774ad51fbd256)
  made (not a lot of them)

## Usage

- Install `ghc` via [GHCup](https://www.haskell.org/ghcup/install/).
  With Arch Linux, `ghcup-hs-bin` package will do

- Play with tests

```bash
cabal test
```

```bash
cabal bench
```

```bash
cabal clean
```

```bash
./test.sh -h
```
