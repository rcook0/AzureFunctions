module.exports = async function (context, myBlob) {
  context.log(`New file detected: ${context.bindingData.name}`);
  context.log(`Size: ${myBlob.length} bytes`);
};
