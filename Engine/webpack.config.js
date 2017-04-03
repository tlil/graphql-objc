var webpack = require('webpack');
var path = require('path');

var libraryName = 'engine';
var outputFile = libraryName + '.js';

var config = {
    entry: __dirname + '/index.js',
    output: {
        path: __dirname,
        filename: outputFile,
        library: libraryName,
        libraryTarget: 'assign'
    }
};

module.exports = config;
