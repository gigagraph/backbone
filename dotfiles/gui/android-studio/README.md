# Android Studio

## Installation

### Download prebuilt

This guide recommend installing Android Studio by downloading it the build from the official website. Unfortunately, at the time of writing, [the AOSP build of Android Studio does not have clear instructions and the provided instructions do not work](#building-from-source-does-not-work).

1. [Download Android Studio build from the official website for your OS and processor][android-studio].
<!-- TODO: instructions to download and install -->
2. TODO

### Building from source (does not work)

> [!NOTE]
>
> Ensure you have the following language toolhcains:
> - [Python](../../../system-setup/toolchains/python/README.md).
> - [Java](../../../system-setup/toolchains/java/README.md).
> - [Bazel](../../../system-setup/toolchains/bazel/README.md).
>
> [You can verify the versions of the installed toolcahins with the script](../system-setup/toolchains/README.md#verify-versions-of-the-installed-toolchains).

> [!WARNING]
>
> This guide does not recommend building Android Studio from sources. At the time of writing AOSP build of Android studio does not work. See the following issues:
> - https://issuetracker.google.com/issues/126764883#comment52.
> - https://issuetracker.google.com/issues/248536235.
> - https://issuetracker.google.com/issues/221359568.

#### Install `repo`

This guide recommends [installing `repo` manually][install-repo]. Assuming that `/usr/local/bin` is on your `$PATH`, run the following commands to install `repo` launcher:

```bash
export REPO=$(mktemp /tmp/repo.XXXXXXXXX)
curl -o "${REPO}" https://storage.googleapis.com/git-repo-downloads/repo
gpg --recv-keys 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65
curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - "${REPO}" && sudo install -m 755 "${REPO}" /usr/local/bin/repo
```

Check that `repo` launcher has successfully been installed:

```bash
repo version
```

#### Install Android Studio from sources

Create the directory to checkout Android Studio branch (`${ANDROID_STUDIO_DIRECTORY}`) and checkout Android Studio sources using [`repo`][#install-repo]:

```bash
# Create the directory
mkdir -p "${ANDROID_STUDIO_DIRECTORY}"
cd "${ANDROID_STUDIO_DIRECTORY}"

# Checkout Android Studio sources
repo init --partial-clone -b "studio-${STUDIO_VERSION}" -u https://android.googlesource.com/platform/manifest
repo sync -c -j4
```

Check the following READMEs to find the build instructions:

- https://cs.android.com/android-studio/platform/tools/base/+/mirror-goog-studio-main:source.md
- https://cs.android.com/android-studio/platform/tools/base/+/mirror-goog-studio-main:studio.md
- https://cs.android.com/android-studio/platform/tools/base/+/mirror-goog-studio-main:bazel/README.md
- https://cs.android.com/android-studio/platform/tools/adt/idea/+/mirror-goog-studio-main:studio/README.md

## Useful links

- [android-studio][android-studio]
- [android-sources][android-sources]
- [android-tools-sources][android-tools-sources]
- [checkout-android-studio-sources][checkout-android-studio-sources]
- [build-android-studio-from-sources][build-android-studio-from-sources]
- [googlesource-repo][googlesource-repo]
- [install-repo][install-repo]

[android-studio]: https://developer.android.com/studio
[android-sources]: https://android.googlesource.com/
[android-tools-sources]: https://android.googlesource.com/
[checkout-android-studio-sources]: https://android.googlesource.com/platform/tools/base/+/studio-master-dev/source.md
[build-android-studio-from-sources]: https://android.googlesource.com/platform/tools/base/+/studio-master-dev/studio.md
[googlesource-repo]: https://gerrit.googlesource.com/git-repo/
[install-repo]: https://source.android.com/docs/setup/start#repo
