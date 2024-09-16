# Workspace setup

## External dependencies

### [`qmk_firmware`](https://github.com/qmk/qmk_firmware)

Keychron's fork of [`qmk_firmware`](https://github.com/qmk/qmk_firmware) at the branch `wireless_playground` is checked in to the sources of this repo using `git subtree` under the `keyboard/qmk/firmware` path.

#### Setup

##### Pull `qmk_firmware` submodules

```shell
git submodule update --init --recursive
```

> [!NOTE]
>
> The `.gitmodules` file just duplicates the contents of the `.gitmodules` files from the dependencies checked in with `git subtree`. The repo maintainer added the corresponding `git subtree` prefix to the relevant places in the repo root `.gitmodules`.

##### QMK CLI

Run the following QMK CLI command from the `qmk_firmware` repo root:

```shell
cd keyboard/qmk/firmware
qmk setup
```

#### Useful links for `qmk_firmware`

Instructions for [setting up the firmware build](https://docs.qmk.fm/newbs_getting_started) can be found in the official docs.
