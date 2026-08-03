theme {
  $background = #101010
  $foreground = #ececec
  $accent = #ececec25
  $muted_foreground = #a0a0a0
  $transparent = #00000000

  name = 'modern'
  view = view.large
  dark = default

  background {
    color = background
    opacity = 100
    effect = 0
  }

  item {
    opacity = 100
    radius = 0
    prefix = 0

    text {
      normal = foreground
      select = foreground
      normal.disabled = muted_foreground
      select.disabled = muted_foreground
    }

    back {
      normal = background
      select = accent
      normal.disabled = transparent
      select.disabled = transparent
    }
  }

  border {
    enabled = false
    size = 2
    color = foreground
    opacity = 100
  }

  shadow {
    enabled = true
    size = 5
    color = background
    opacity = 5
  }

  font {
    size = 20
    name = 'JetBrainsMono NFP'
    weight = 1
    italic = 0
  }

  separator {
    size = 1
    color = transparent
  }

  symbol {
    normal = foreground
    select = foreground
    normal.disabled = muted_foreground
    select.disabled = muted_foreground
  }

  image {
    align = 2
  }
}

