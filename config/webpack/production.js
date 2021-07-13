process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')
const webpack = require('webpack')

environment.plugins.append(
    'DefinePlugin',
    new webpack.DefinePlugin({
        __VUE_OPTIONS_API__: true,
        __VUE_PROD_DEVTOOLS__: false
    })
)

module.exports = environment.toWebpackConfig()
