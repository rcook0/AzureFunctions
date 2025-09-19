module.exports = async function (context, myBlob) {
  context.log(`Blob received for Cosmos insert, size: ${myBlob.length}`);
  context.bindings.document = {
    id: context.bindingData.name,
    timestamp: new Date(),
    payload: myBlob.toString()
  };
};