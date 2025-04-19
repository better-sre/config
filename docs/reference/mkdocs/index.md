# MkDocs

## mkdocs plugins

- [mkdocs plugins](https://github.com/mkdocs/catalog)

### 导出PDF

- <https://doc.courtbouillon.org/weasyprint/stable/first_steps.html#macos>

```ruby
brew install pango libffi
brew install glib
brew link glib

brew install weasyprint




```

- fix: <https://github.com/Kozea/WeasyPrint/issues/1448>

```ruby

sudo ln -s /opt/homebrew/opt/glib/lib/libgobject-2.0.0.dylib /usr/local/lib/gobject-2.0
sudo ln -s /opt/homebrew/opt/pango/lib/libpango-1.0.dylib /usr/local/lib/pango-1.0
sudo ln -s /opt/homebrew/opt/harfbuzz/lib/libharfbuzz.dylib /usr/local/lib/harfbuzz
sudo ln -s /opt/homebrew/opt/fontconfig/lib/libfontconfig.1.dylib /usr/local/lib/fontconfig-1
sudo ln -s /opt/homebrew/opt/pango/lib/libpangoft2-1.0.dylib /usr/local/lib/pangoft2-1.0
```

## 其他文档

- Full Url: <https://lukasgeiter.github.io/mkdocs-awesome-nav>
- Relative Path: ../
