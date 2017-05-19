var webpack = require('webpack');
var path = require('path');

var libraryName = '[name]';
var outputFile = 'output.[name].js';

var config = {
    entry: {
        promise: __dirname + '/promise.generated.js',
        engine: __dirname + '/index.generated.js'
    },
    output: {
        path: __dirname,
        filename: outputFile,
        library: libraryName,
        libraryTarget: 'assign'
    }
};

module.exports = config;
