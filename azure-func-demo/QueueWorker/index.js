module.exports = async function (context, queueItem) {
  const content = JSON.stringify({ received: new Date(), data: queueItem });
  context.bindings.outputBlob = content;
  context.log(`Queue item processed to blob`);
};