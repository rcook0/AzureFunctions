module.exports = async function (context, myTimer) {
  context.log(`Timer ran at: ${new Date().toISOString()}`);
};
