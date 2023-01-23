// Import Packages
const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv')
const cors = require('cors');

// Init
const app = express();
app.use(cors());
app.use(express.json());
dotenv.config();


// Import Files
const userRoutes = require('./routes/users');
const carRoutes = require('./routes/cars');
const clientRoutes = require('./routes/clients');
const bankRoutes = require('./routes/banks');
const creditorRoutes = require('./routes/creditors');
const debitsRoutes = require('./routes/debits');
const shipmentRoutes = require('./routes/shipments');
const policesRoutes = require('./routes/polices');
const transferRoutes = require('./routes/transfers');
const buyGoodsRoutes = require('./routes/buy-goods');
const typeGoodsRoutes = require('./routes/type-goods');
const employeesRoutes = require('./routes/employees');
const empMoneyRoutes = require('./routes/emp-money');
const expensesRoutes = require('./routes/expenses');

// Router
app.use('/api/users', userRoutes);
app.use('/api/cars', carRoutes);
app.use('/api/clients', clientRoutes);
app.use('/api/banks', bankRoutes);
app.use('/api/creditors', creditorRoutes);
app.use('/api/debits', debitsRoutes);
app.use('/api/shipments', shipmentRoutes);
app.use('/api/polices', policesRoutes);
app.use('/api/transfers', transferRoutes);
app.use('/api/buy-goods', buyGoodsRoutes);
app.use('/api/type-goods', typeGoodsRoutes);
app.use('/api/employees', employeesRoutes);
app.use('/api/emp-money', empMoneyRoutes);
app.use('/api/expenses', expensesRoutes);

mongoose.set('strictQuery', false);
// Database Initialize
mongoose.connect(process.env.MONGO_URL, {
	useNewUrlParser: true,
	useUnifiedTopology: true,
})
	.then(() => console.log('Database Connected...'))
	.catch(e => console.log(e.message));

// Run Server
app.listen(process.env.PORT || 5000, () => {
	console.log(`Server is running\nHost: ${process.env.HOST}\nPort: ${process.env.PORT || 5000}`);
});