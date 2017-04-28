var { graphql, buildSchema } = require('graphql');

var _schema = null;

function _buildSchema(schema) {
  _schema = buildSchema(schema);
  _registerInterfaces(schema);
}

function _executeQuery(query, variables, operationName, root, callback) {
  graphql(_schema, query, root, null, variables, operationName).then((response) => {
    callback(null, JSON.stringify(response));
  }).catch((error) => {
    callback(JSON.stringify(error), null);
  });
}

function _registerInterfaces(schema) {
  const lines = schema.split('\n');
  const interfaces = lines.
    filter((line) => line.indexOf('interface ') === 0).
    map((line) => line.replace(/^interface ([^ ]+)[{ ]*$/g, '$1'));
  for (const interfaceName of interfaces) {
    _registerInterface(interfaceName);
  }
}

function _registerInterface(interfaceName) {
  _schema._typeMap[interfaceName].resolveType = (obj) => {
    return !!obj.__typename ? obj.__typename() : null;
  };
}

module.exports = {
  buildSchema: _buildSchema,
  executeQuery: _executeQuery,
};
