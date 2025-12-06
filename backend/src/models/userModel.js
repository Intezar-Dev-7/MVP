import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    firebaseUid: {
        type: String,
        required: true,
        unique: true,
        index: true
    },
    name: String,
    email: String,
    profilePic: String,
}, { timestamps: true });



const newUser = mongoose.model(
    "newUser",
    userSchema
);

export default newUser;

/*
mongoose.model() = creates a link between schema and MongoDB collection.
export default = allows you to import and use it anywhere else in your app.
*/