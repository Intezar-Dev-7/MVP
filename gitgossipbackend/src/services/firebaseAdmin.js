
import admin from "firebase-admin";
import { createRequire } from "module";

// Only initialize if not already initialized (prevents errors on hot reload)
if (!admin.apps.length) {
    // Option 1: Using service account JSON file (your current approach)
    const _require = createRequire(import.meta.url);
    const serviceAccount = _require("./serviceAccountKey.json");

    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount),
    });

    console.log("✅ Firebase Admin initialized successfully");
} else {
    console.log("ℹ️ Firebase Admin already initialized");
}

export default admin;