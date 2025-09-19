module.exports = async function (context, myQueueItem) {
  context.log(`Processing: ${myQueueItem}`);
};
