const router = require('express').Router();
const {verifyAdmin} = require('../middleware/verify-token');
const empMoneyController = require('../controllers/empmoney_controller');


// Create A New Transfer
router.post('/', verifyAdmin, empMoneyController.create);

// Update Transfer
router.put('/:id', verifyAdmin, empMoneyController.update);

// Remove Transfer
router.delete('/:id', verifyAdmin, empMoneyController.remove);


module.exports = router;