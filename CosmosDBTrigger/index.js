module.exports = async function (context, documents) {
  if (documents && documents.length > 0) {
    context.log(`Detected ${documents.length} document changes`);
    documents.forEach(doc => context.log(JSON.stringify(doc)));
  }
};
