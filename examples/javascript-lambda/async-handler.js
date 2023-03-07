'use strict';


exports.handler = async (event, context) => {
  const cfEvent = event.Records[0].cf;

  // Compatibility layer required to convert from Node.js req/res <-> CloudFront responses
  const { req, res, responsePromise } = lambdaAtEdgeCompat(cfEvent, { enableHTTPCompression: false });

  try {
    await handler(new NodeNextRequest(req), new NodeNextResponse(res))
  } catch (err) {
    console.error(err);
    res.statusCode = 500
    res.end('internal server error. '+ (new Date()))
  }

  const response = await responsePromise;

  // Remove any blacklisted headers from CloudFront response
  if (response.headers) {
    removeBlacklistedHeaders(response.headers);
  }

  return response;
};
