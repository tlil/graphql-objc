var { graphql, buildSchema } = require('graphql');

var _schema = null;

function _buildSchema(schema) {
  _schema = buildSchema(schema);
}

function _executeQuery(query, variables, operationName, root, callback) {
  graphql(_schema, query, root, null, variables, operationName).then((response) => {
    callback(null, JSON.stringify(response));
  }).catch((error) => {
    callback(JSON.stringify(error), null);
  });
}

module.exports = {
  buildSchema: _buildSchema,
  executeQuery: _executeQuery,
};
