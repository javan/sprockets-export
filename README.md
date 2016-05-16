# Sprockets Export

A [Sprockets directive](https://github.com/rails/sprockets#sprockets-directives) for hassle-free [UMD](https://github.com/umdjs/umd)-style JavaScript module definitions.

## Using

``` ruby
# Gemfile

gem 'sprockets', '>= 3.0.0'
gem 'sprockets-export'
```

```js
/* widget.js */

//= export Widget
//= require_self

this.Widget = { name: "gizmo" }
```

## Consuming

```js
widget = require("widget")
widget.name // gizmo
```

---

Licensed under the [MIT License](LICENSE.txt)

© 2016 Javan Makhmali
