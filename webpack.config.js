var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
  entry: {
    index: [
      './source/css/styles.scss',
      './source/javascripts/all.js'
    ]
  },

  resolve: {
    root: __dirname + '/source/javascripts',
  },

  output: {
    path: __dirname + '/.tmp/dist',
    filename: 'javascripts/[name].js',
  },

  module: {
    loaders: [{
      test: /source\/javascripts\/.*\.js$/,
      exclude: /node_modules|\.tmp/,
      loaders: ['babel'],
    }, {
      test: /.*\.scss$/,
      // loaders: ['style', 'css', 'sass']
      loader: ExtractTextPlugin.extract(
        "style",
        "css!sass?sourceMap&includePaths[]=" + __dirname + "/node_modules"
      )
    }]
  },

  plugins: [
    new ExtractTextPlugin("stylesheets/app.css")
  ]
};
