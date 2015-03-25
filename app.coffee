axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
records      = require 'roots-records'
templates    = require 'client-templates'
config       = require 'roots-config'
S            = require 'string'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

  extensions: [
    js_pipeline(files: 'assets/js/*.coffee'),
    css_pipeline(files: 'assets/css/*.styl'),
    templates(base: 'views/templates'),
    records({
      pagelist: {
        url: "http://pcpc.org/api/pages/",
        path: "response/pages/item"
      },
      pages: {
        url: "http://pcpc.org/api/pages/",
        template: "views/_single.jade",
        collection: (d) -> d.response.pages.item,
        out: (page) -> "/page/#{S(page.name).slugify().s}"
      }
    })
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true

  server:
    clean_urls: true
