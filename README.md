# TrackMania Cup of the Day Countdown

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
