const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

module.exports = environment

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jQuery',
    jQuery: 'jQuery',
    jquery: 'jQuery'
  })
)

module.exports = environment
