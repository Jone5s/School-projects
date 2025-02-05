// Import the jwt module for handling JSON Web Tokens
const jwt = require('jsonwebtoken');

/**
 * Middleware function to verify the validity of a JWT provided in the request headers.
 * This function ensures that the user making the request has a valid token and is authorized.
 *
 * @param {object} req - The request object from Express.js, containing information about the HTTP request.
 * @param {object} res - The response object from Express.js, used to send back the desired HTTP response.
 * @param {function} next - A callback function to signal the completion of middleware processing and to continue
 *                          with the execution of subsequent middleware functions.
 */
const verifyToken = (req, res, next) => {
  // OPTIONS requests are preflight requests in CORS and do not need authorization checks
  if (req.method === 'OPTIONS') {
    return next(); // Allow the OPTIONS request to proceed without token verification
  }

  // Attempt to extract the token from the 'Authorization' header, which is expected in the format 'Bearer [token]'
  const token = req.headers.authorization && req.headers.authorization.split(' ')[1];

  // If no token is found, return an error
  if (!token) {
    return res.status(401).json({ message: 'Authorization failed: Token missing' });
  }

  try {
    // Verify the token using the secret key from the environment variables
    const decodedToken = jwt.verify(token, process.env.JWT_KEY);
    
    // Attach decoded user data (user ID) to the request object for use in subsequent middleware or routing logic
    req.userData = { userId: decodedToken.id };
    
    // Continue to the next middleware function
    next();
  } catch (error) {
    // If token verification fails, return an authorization failure response
    return res.status(401).json({ message: 'Authorization failed: Invalid token' });
  }
};

// Export the verifyToken middleware to be used in other parts of the application
module.exports = verifyToken;
