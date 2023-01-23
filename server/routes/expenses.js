const router = require('express').Router();
const {verifyToken, verifyAdmin} = require('../middleware/verify-token');
const expensesController = require('../controllers/expenses_controller');
// Create New
router.post('/', verifyAdmin, expensesController.create);

// Update
router.put('/:id', verifyAdmin, expensesController.update);

// Remove
router.delete('/:id', verifyAdmin, expensesController.remove);

// Get All
router.get('/', verifyToken, expensesController.getAll);

// Get One 
router.get('/:id', verifyToken, expensesController.show);

module.exports = router;