const express = require('express')
const app = express()
require('dotenv').config()
var cors = require('cors')
const mongoose = require('mongoose');



mongoose.connect('mongodb+srv://tunglatoi2004-APP:tunglatoi2004@cluster0.anf8a.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0', {
    useNewUrlParser: true,
    useUnifiedTopology: true
}).then(() => {
    console.log('Connected to MongoDB Atlas');
}).catch((err) => {
    console.error('Error connecting to MongoDB:', err);
});
// Kết nối MongoDB

// Middleware
app.use(cors());


// Định nghĩa route cho location
const tripRoute = require('./api/routes/trip.route');
const addressRoute = require('./api/routes/address.route');
const userRoute = require('./api/routes/users.route');

app.use('/user', userRoute);
app.use('/address', addressRoute);
app.use('/trip', tripRoute);

// Route chính
app.get('/', (req, res) => res.send('Thien đang học Node.js'));

// Khởi động server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server is running on http://localhost:${PORT}`));