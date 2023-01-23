const router = require('express').Router();
const {verifyToken, verifyAdmin} = require('../middleware/verify-token');
const typegoodsController = require('../controllers/typegoods_controller');

// Create A New TypeGoods
router.post('/', verifyAdmin, typegoodsController.create);

// Update TypeGoods
router.put('/:id', verifyAdmin, typegoodsController.update);

// Remove TypeGoods
router.delete('/:id', verifyAdmin, typegoodsController.remove);

// Get All TypeGoods
router.get('/', verifyToken, typegoodsController.getAll);

// Show One
router.get('/:id', verifyToken, typegoodsController.show);

module.exports = router;