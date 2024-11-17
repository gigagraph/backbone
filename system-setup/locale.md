# Locale

## Generate locales

Uncomment the desired locales in `/etc/locale.gen`:

```sudo
sudo vi /etc/locale.gen
```

Generate locale files:

```shell
sudo locale-gen
```

## Configure

Set local settings in `/etc/locale.conf`. E.g. to use the US locale with a metric system and a Ukrainian datetime format set the following:

```
LANG=en_US.UTF-8
LC_MEASUREMENT=metric
LC_TIME=uk_UA.UTF-8
```

`set-locale` with `localetl`:

```shell
sudo localectl set-locale LANG=en_US.UTF-8
sudo localectl set-locale LC_MEASUREMENT=metric
sudo localectl set-locale LC_TIME=uk_UA.UTF-8
```

## Useful links

- [arch-wiki-locale][arch-wiki-locale]

[arch-wiki-locale]: <https://wiki.archlinux.org/title/Locale#Metric_measurements_with_US_locale>
