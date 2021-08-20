process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')
const webpack = require('webpack')

module.exports = environment.toWebpackConfig()
