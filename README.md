# TrackMania Cup of the Day Countdown

[![Total Downloads](https://img.shields.io/badge/dynamic/json?color=green&label=Downloads&query=downloads&url=https%3A%2F%2Fopenplanet.dev%2Fapi%2Fplugin%2F131)](https://openplanet.dev/plugin/cotdcountdown)


OpenPlanet plugin for TrackMania that displays a countdown until next Cup of the Day (COTD)

## Releases

Releases are available from OpenPlanet: https://openplanet.nl/files/131

## Settings configuration

Text color and text position are configurable via Settings.ini

For example, if you want white text in the top right corner, add the following section to the Settings.ini

```
[CotdCountdown]
colorCode=\$FFF
textPosition=4
```

## Contributions welcome!

Feel free to make changes and open a PR. Open an issue if you have any questions!

## Creating a release

1. Update the version in [info.toml](./info.toml#L8)
2. Create a push a git tag
    ```
    git tag 0.0.3
    git push origin 0.0.3
    ```
