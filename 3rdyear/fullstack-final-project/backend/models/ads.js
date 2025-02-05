// Import the pre-configured MySQL connection pool
const pool = require('../db/pool');

const ads = {
  // Method to fetch all advertisements from the database
  findAds: async () => {
    try {
      const connection = await pool.getConnection(); // Get a connection from the pool
      const [results] = await connection.query('SELECT * FROM `ads`'); // Execute a query to select all ads
      connection.release(); // Release the connection back to the pool
      return results; // Return the results of the query
    } catch (error) {
      console.error("Failed to fetch ads:", error); // Log error if the operation fails
      throw new Error(error); // Re-throw the error for upstream handling
    }
  },

  // Method to find a single advertisement by ID
  findAdById: async (id) => {
    try {
      const connection = await pool.getConnection();
      const [results] = await connection.query('SELECT * FROM `ads` WHERE id = ?', [id]); // Query ads by ID
      connection.release();
      return results;
    } catch (error) {
      console.error("Failed to find ad by ID:", error);
      throw new Error(error);
    }
  },

  // Method to insert a new advertisement into the database
  createNewAd: async (ad) => {
    let connection;
    try {
      connection = await pool.getConnection();
      const [results] = await connection.query('INSERT INTO `ads` SET ?', [ad]); // Use placeholders for data insertion
      connection.release();
      return results;
    } catch (error) {
      console.error("Failed to create new ad:", error);
      if (connection) connection.release(); // Ensure connection is released even if an error occurs
      throw error; // Preserve original error
    }
  },

  // Method to find advertisements by make and model
  findByMakeAndModel: async (make, model) => {
    try {
      const connection = await pool.getConnection();
      const [results] = await connection.query('SELECT * FROM `ads` WHERE make = ? AND model = ?', [make, model]);
      connection.release();
      return results;
    } catch (error) {
      console.error("Failed to find ad by make and model:", error);
      throw new Error(error);
    }
  },

  // Method to update an advertisement by ID
  updateAdById: async (ad) => {
    try {
      const connection = await pool.getConnection();
      const sql = `
        UPDATE \`ads\` SET 
        make = ?, 
        model = ?, 
        image = ?, 
        price = ?, 
        description = ?, 
        hp = ?, 
        fueltype = ?, 
        displacement = ?, 
        end_time = ?
        WHERE id = ?
      `;
      const params = [ad.make, ad.model, ad.image, ad.price, ad.description, ad.hp, ad.fueltype, ad.displacement, ad.end_time, ad.id];
      const [results] = await connection.query(sql, params); // Execute the update with prepared statements
      connection.release();
      return results;
    } catch (error) {
      console.error("Failed to update ad:", error);
      throw new Error(error);
    }
  },

  // Method to delete an advertisement by ID
  deleteAdById: async (id) => {
    try {
      const connection = await pool.getConnection();
      const [results] = await connection.query('DELETE FROM `ads` WHERE id = ?', [id]);
      connection.release();
      return results;
    } catch (error) {
      console.error("Failed to delete ad:", error);
      throw new Error(error);
    }
  },
  
  // Method to update the price of an advertisement by ID
  updateAdPriceById: async (id, newPrice) => {
    try {
      const connection = await pool.getConnection();
      const sqlQuery = 'UPDATE `ads` SET price = ? WHERE id = ?';
      const [results] = await connection.query(sqlQuery, [newPrice, id]);
      connection.release();
      return results;
    } catch (error) {
      console.error("Failed to update ad price:", error);
      throw new Error(error);
    }
  },

  // Method to fetch advertisements created by a specific creator ID
  findAdsByCreatorId: async (creatorId) => {
    let connection;
    try {
      connection = await pool.getConnection();
      const sqlQuery = 'SELECT * FROM `ads` WHERE creatorId = ?';
      const [results] = await connection.query(sqlQuery, [creatorId]);
      connection.release();
      return results;
    } catch (error) {
      console.error("Failed to fetch ads by creator ID:", error);
      if (connection) connection.release(); // Ensure connection is released even if an error occurs
      throw new Error(error);
    }
  }
}

// Export the ads object with its methods for use in other parts of the application
module.exports = ads;
