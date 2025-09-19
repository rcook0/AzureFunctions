module.exports = async function (context, req) {
  context.res = {
    status: 200,
    body: `Hello ${req.query.name || "World"}`
  };
};
