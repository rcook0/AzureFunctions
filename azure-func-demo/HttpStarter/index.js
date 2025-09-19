module.exports = async function (context, req) {
  const task = req.body || { text: "default" };
  context.bindings.outQueue = JSON.stringify(task);

  context.res = {
    status: 202,
    body: { message: "Task queued", task }
  };
};