module.exports = async function (context, documents) {
  if (documents && documents.length > 0) {
    context.log(`New Cosmos items: ${documents.length}`);
    documents.forEach(doc => context.log(JSON.stringify(doc)));
  }
};