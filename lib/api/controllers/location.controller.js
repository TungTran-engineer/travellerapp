const locationsSchema = require('../models/location.model')

const locationController = {
    getLocations: async (req, res) => {
        try {
            const location = await locationsSchema.find()
            res.status(200).json(location)
        }catch(error){
            res.status(500).json({message: error.message});
        }
    },
    createLocations: async (req, res) => {
        try {
            const location = new locationsSchema(req.body)
            const saveLocation = await location.save();
            res.status(200).json(saveLocation);
        }catch(error){
            res.status(500).json({message: error.message});
        }
    },
    deleteLocations: async (req, res) => {
        try {
            const location = locationsSchema.find()
            const removeLocation = await location.deleteOne();
            res.status(200).json(removeLocation);
        }catch(error){
            res.status(500).json({message: error.message});
        }
    }
} 

module.exports = locationController