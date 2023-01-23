const router = require('express').Router();
const buyGoodsController = require('../controllers/buygoods_controller');
const {verifyAdmin} = require('../middleware/verify-token');

// Create A New BuyGoods
router.post('/', verifyAdmin, buyGoodsController.create);

// Update BuyGoods
router.put('/:id', verifyAdmin, buyGoodsController.update);

// Remove BuyGoods
router.delete('/:id', verifyAdmin, buyGoodsController.remove);




module.exports = router;