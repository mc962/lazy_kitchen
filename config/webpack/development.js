process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
const webpack = require('webpack')

// Build Analysis Tools
const CircularDependencyPlugin = require('circular-dependency-plugin')
environment.plugins.append(
    'CircularDependencyPlugin',
    new CircularDependencyPlugin()
)
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;
environment.plugins.append(
    'BundleAnalyzerPlugin',
    new BundleAnalyzerPlugin()
)
const SpeedMeasurePlugin = require("speed-measure-webpack-plugin");
const smp = new SpeedMeasurePlugin();
const webpackConfig = smp.wrap(environment.toWebpackConfig());
module.exports = webpackConfig

// module.exports = environment.toWebpackConfig()
