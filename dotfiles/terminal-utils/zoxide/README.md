# `zoxide`

## Installation

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Rust](../../system-setup/toolchains/rust/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

Ensure you install [`fzf`](../fzf/README.md) before proceeding.

This guide recommends installing `zoxide` with `cargo`:

```shell
cargo install zoxide --all-features --locked
```

### Integrate `zoxide` with other programs

#### zsh

See the corresponding section in the [zsh docs file in this repo](../../zsh/README.md#zoxide).

#### Neovim

- [ ] TODO: refer to corresponding section in the [neovim docs](../../neovim/README.md), when it is ready. Potential plugins:
  - https://github.com/nanotee/zoxide.vim
  - https://github.com/jvgrootveld/telescope-zoxide

## Algorithm

> [!NOTE]
>
> Copied from https://github.com/ajeetdsouza/zoxide/wiki.

`zoxide` uses a simple, predictable algorithm for resolving queries:
1. All matching is **case-insensitive**.
  - `z` foo matches `/foo` as well as `/FOO`.
2. All terms must be present (including slashes) within the path, in order.
  - `z fo ba` matches `/foo/bar/`, but not `/bar/foo`.
  - `z fo / ba` matches `/foo/bar`, but not `/foobar`.
3. The last component of the last keyword must match the last component of the path.
  - `z bar` matches `/foo/bar`, but not `/bar/foo`.
  - `z foo/bar` (last component: `bar`) matches `/foo/bar`, but not `/foo/bar/baz`.
4. Matches are returned in descending order of **frecency** (frequency + recency).

## Useful links

- [github-zoxide][github-zoxide]
- [youtube-dream-of-autonomy-zoxide-setup][youtube-dream-of-autonomy-zoxide-setup]

[github-zoxide]: <https://github.com/ajeetdsouza/zoxide>
[youtube-dream-of-autonomy-zoxide-setup]: <https://www.youtube.com/watch?v=aghxkpyRVDY>
