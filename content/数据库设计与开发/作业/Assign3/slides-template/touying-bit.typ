
// Stargazer theme - adapted for BIT color-theme
// the original theme is https://github.com/Coekjan/touying-buaa

#import "@preview/touying:0.6.0": *
#import themes.stargazer: *

#let bit-theme(
  aspect-ratio: "16-9",
  lang: "en",
  font: ("Noto Sans SC", "Times New Roman", "SimHei"),
  logo-path: "assets/bit-cs.png",
  ..args,
  body,
) = {
  set text(lang: lang, font: font)
  show: if lang == "zh" {
    it => it
  } else {
    it => it
  }

  show: stargazer-theme.with(
    aspect-ratio: aspect-ratio,
    config-info(logo: image(logo-path)),
    config-colors(
      primary: rgb("#1ca469"),
      primary-dark: rgb("#006048"),
      secondary: rgb("#ffffff"),
      tertiary: rgb("#359a63"),
      neutral-lightest: rgb("#fcfff5"),
      neutral-darkest: rgb("#05261e"),
    ),
    ..args,
  )

  body
}
