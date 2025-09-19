const df = require("durable-functions");

module.exports = df.orchestrator(function* (context) {
  const outputs = [];
  outputs.push(yield context.df.callActivity("SayHello", "Tokyo"));
  outputs.push(yield context.df.callActivity("SayHello", "Seattle"));
  outputs.push(yield context.df.callActivity("SayHello", "London"));
  return outputs;
});
