const router = require('express').Router();
const {verifyAdmin} = require('../middleware/verify-token');
const transferController = require('../controllers/transfers_controller');


// Create A New Transfer
router.post('/', verifyAdmin, transferController.create);

// Update Transfer
router.put('/:id', verifyAdmin, transferController.update);

// Remove Transfer
router.delete('/:id', verifyAdmin, transferController.remove);


module.exports = router;