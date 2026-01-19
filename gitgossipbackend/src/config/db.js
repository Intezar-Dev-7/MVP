
import mongoose from "mongoose";
import dotenv from "dotenv";
export const ConnectDB = async () => {
    try {
        await mongoose.connect(process.env.MONGO_DB_URI, {
            serverSelectionTimeoutMS: 5000,
            family: 4,  // <-- Correct place
        });

        console.log("MongoDB Connected ✔");
    } catch (error) {
        console.error("MongoDB Connection Error ❌", error);
        process.exit(1);
    }
};
