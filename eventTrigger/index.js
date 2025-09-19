module.exports = async function (context, event) {
  context.log(`Event received: ${event.eventType} - ${event.subject}`);
};
