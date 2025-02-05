// Load Joi for data validation and ads model for database operations
const Joi = require('joi');
const ads = require('../models/ads');

// Schema definition for inserting a new ad
const adInsertSchema = Joi.object({
  make: Joi.string().required().min(1).max(60),
  model: Joi.string().required().min(1).max(60),
  image: Joi.string().min(1).max(200),
  price: Joi.number().integer().min(0),
  description: Joi.string().max(500),
  hp: Joi.number().integer(),
  fueltype: Joi.string().max(10),
  displacement: Joi.string().max(4),
  end_time: Joi.date().iso().optional(),
  creatorId: Joi.string().guid().required() // Validate UUID format for creatorId
});

// Schema for updating existing ad entries
const adUpdateSchema = Joi.object({
  id: Joi.number().required().integer(),
  make: Joi.string().required().min(1).max(60),
  model: Joi.string().required().min(1).max(60),
  image: Joi.string().min(1).max(200),
  price: Joi.number().integer().min(0),
  description: Joi.string().max(500),
  hp: Joi.number().integer(),
  fueltype: Joi.string().max(10),
  displacement: Joi.string().max(4),
  end_time: Joi.date().iso().optional(),
  creatorId: Joi.string().guid().required()
});

// Schema for updating the price of an ad
const priceUpdateSchema = Joi.object({
  price: Joi.number().integer().min(0).required()
});

// Retrieve all ads
const getAds = async (req, res) => {
  try {
    const response = await ads.findAds();
    res.json(response);
  } catch (error) {
    res.status(500).json({message: "Something went wrong"});
  }
};

// Retrieve a single ad by its ID
const getAdById = async (req, res) => {
  try {
    const id = parseInt(req.params.id);
    const response = await ads.findAdById(id);
    response.length === 0 ? res.status(404).json({ message: "Ad not found"}) : res.json(response[0]);
  } catch (error) {
    res.status(500).json({message: "Something went wrong"});
  }
};

// Create a new ad
const createAd = async (req, res) => {
  try {
    const creatorId = req.userData.userId;
    const adData = {...req.body, creatorId: creatorId};
    const { error } = adInsertSchema.validate(adData);
    if (error) {
      return res.status(400).json({ message: error.details[0].message });
    }
    const response = await ads.createNewAd(adData);
    if (response.affectedRows === 1) {
      return res.json({ message: "Ad added successfully", id: response.insertId });
    }
    return res.status(500).json({ message: "Could not add the ad" });
  } catch (error) {
    console.error("Error creating ad:", error);
    return res.status(500).json({ message: "Something went wrong" });
  }
};

// Update an existing ad
const updateAd = async (req, res) => {
  try {
    const adId = req.body.id;
    const ad = await ads.findAdById(adId);
    if (ad[0].creatorId !== req.userData.userId) {
      return res.status(403).json({ message: 'Forbidden: You are not allowed to update this ad' });
    }
    const { error } = adUpdateSchema.validate(req.body);
    if (error) {
      return res.status(400).json({ message: error.details[0].message });
    }
    const response = await ads.updateAdById(req.body);
    response.affectedRows === 1 ? res.json({ message: "Ad updated successfully" }) : res.status(404).json({ message: "Ad not found" });
  } catch (error) {
    return res.status(500).json({ message: "Something went wrong" });
  }
};

// Delete an ad
const deleteAd = async (req, res) => {
  try {
    const adId = parseInt(req.params.id, 10);
    const ad = await ads.findAdById(adId);
    console.log("Ad object:", ad);
    if (!ad) {
      return res.status(404).json({ message: "Ad not found" });
    }
    if (ad[0].creatorId !== req.userData.userId) {
      return res.status(403).json({ message: 'Forbidden: You are not allowed to delete this ad' });
    }
    const response = await ads.deleteAdById(adId);
    if (response.affectedRows === 1) {
      return res.json({ message: 'Ad deleted' });
    } else {
      return res.status(404).json({ message: "Ad not found" });
    }
  } catch (error) {
    res.status(500).json({ message: "Something went wrong", error: error });
  }
};

// Update the price of an ads
const updateAdPrice = async (req, res) => {
  const { price } = req.body;
  const adId = req.params.id;
  const { error } = priceUpdateSchema.validate({ price });
  if (error) {
    return res.status(400).json({ message: error.details[0].message });
  }
  try {
    const result = await ads.updateAdPriceById(adId, price);
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'Ad not found' });
    }
    res.json({ message: 'Price updated successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Failed to update ad price', error: error.message });
  }
};

// Retrieve all ads created by a specific creator using their ID
const getAdsByCreatorId = async (req, res) => {
  try {
    const creatorId = req.query.creatorId;
    if (!creatorId) {
      return res.status(400).json({ message: "Creator ID is required" });
    }
    const ads = await ads.findAdsByCreatorId(creatorId);
    if (ads.length === 0) {
      return res.status(404).json({ message: "No ads found" });
    }
    res.json(ads);
  } catch (error) {
    res.status(500).json({ message: "Failed to fetch ads", error: error.message });
  }
};

// Exporting the functions to be available for router setup in other files
module.exports = {
  createAd,
  deleteAd,
  getAds,
  getAdById,
  updateAd,
  updateAdPrice,
  getAdsByCreatorId
}
