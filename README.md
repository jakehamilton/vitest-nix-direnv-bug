# Vitest ☠️ Nix DirEnv

This repository contains a reproduction of a startup issue with Vitest.

Table of Contents

- [Setup](#setup)
- [Reproduction](#reproduction)
- [Fix](#fix)

## Setup

1. Make sure you have [Nix](https://nixos.org) installed and have [nix-direnv](https://github.com/nix-community/nix-direnv) enabled.

2. Clone this repository.

```bash
git clone git@github.com:jakehamilton/vitest-nix-direnv-bug.git

cd vitest-nix-direnv-bug
```

3. Allow this repository's `.envrc` file to get into a development environment.

```bash
direnv allow
```

4. Install NPM dependencies.

```bash
npm install
```

## Reproduction

### With `.direnv` directory

The `.direnv` directory is a cache directory where the project's development environment
is stored. This directory appears to be causing issues with Vitest, making the process take
a long time before it runs tests.

To reproduce the issue, ensure you have allowed the `.envrc` in this repository and have
entered a development shell (happens automatically if you are within this project directory).

```bash
direnv allow

npx vitest
```

### Without `.direnv` directory

Denying this repository's `.envrc` and removing the `.direnv` directory resolves the startup
issue, but now we're unable to ship reproducible development environments. Note that the issue
still persists as long as the `.direnv` directory exists, regardless of whether the `.envrc` is
allowed or whether you are in a development shell or not.

To resolve the issue, deny the `.envrc` in this repository and remove the `.direnv` directory.

```bash
direnv deny

rm -r .direnv

npx vitest
```

## Fix

To resolve this issue, tell Vite _and_ Vitest to ignore the `.direnv` directory.

```ts
import { defineConfig } from "vite";

// https://vitejs.dev/config/
export default defineConfig({
	server: {
		watch: {
			ignored: ["**/.direnv"],
		},
	},
	test: {
		exclude: [".direnv"],
	},
});
```
