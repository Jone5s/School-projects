const express = require('express');
const { 
  createAd, 
  deleteAd, 
  getAds, 
  getAdById, 
  updateAd,
  updateAdPrice,
  getAdsByCreatorId 
} = require('../controllers/ads');

const verifyToken = require('../middleware/verifyToken');

const router = express.Router();

router.get('/', getAds);
router.get('/:id', getAdById);
router.patch('/:id/price', updateAdPrice);

router.use(verifyToken);
router.post('/', createAd)
router.put('/', updateAd);
router.delete('/:id', deleteAd);
router.get('/api/ads/by-creator', getAdsByCreatorId);

module.exports = router;
