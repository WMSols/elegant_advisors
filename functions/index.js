const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

const db = admin.firestore();
const auth = admin.auth();

/**
 * Helper function to verify if the caller is an admin
 */
async function verifyAdmin(context) {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated'
    );
  }

  const uid = context.auth.uid;
  const adminDoc = await db.collection('admin_users').doc(uid).get();

  if (!adminDoc.exists) {
    throw new functions.https.HttpsError(
      'permission-denied',
      'User does not have admin privileges'
    );
  }

  return uid;
}

/**
 * Create a new admin user
 * Requires: { email, password, name }
 */
exports.createAdminUser = functions.https.onCall(async (data, context) => {
  try {
    // Verify the caller is an admin
    await verifyAdmin(context);

    const { email, password, name } = data;

    // Validate input
    if (!email || !password || !name) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Email, password, and name are required'
      );
    }

    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Invalid email format'
      );
    }

    // Validate password length
    if (password.length < 8) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Password must be at least 8 characters long'
      );
    }

    // Check if user already exists
    let userRecord;
    try {
      userRecord = await auth.getUserByEmail(email);
      throw new functions.https.HttpsError(
        'already-exists',
        'A user with this email already exists'
      );
    } catch (error) {
      if (error.code === 'functions/already-exists') {
        throw error;
      }
      // User doesn't exist, continue
    }

    // Create user in Firebase Auth
    userRecord = await auth.createUser({
      email: email,
      password: password,
      emailVerified: false,
    });

    // Create admin user document in Firestore
    const adminUserData = {
      email: email,
      name: name.trim(),
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    await db.collection('admin_users').doc(userRecord.uid).set(adminUserData);

    return {
      success: true,
      uid: userRecord.uid,
      email: userRecord.email,
      message: 'Admin user created successfully',
    };
  } catch (error) {
    console.error('Error creating admin user:', error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError(
      'internal',
      'Failed to create admin user: ' + error.message
    );
  }
});

/**
 * Delete an admin user
 * Requires: { uid }
 */
exports.deleteAdminUser = functions.https.onCall(async (data, context) => {
  try {
    // Verify the caller is an admin
    const callerUid = await verifyAdmin(context);

    const { uid } = data;

    if (!uid) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'User ID is required'
      );
    }

    // Prevent self-deletion
    if (uid === callerUid) {
      throw new functions.https.HttpsError(
        'permission-denied',
        'Cannot delete your own account'
      );
    }

    // Verify the user exists in admin_users collection
    const adminDoc = await db.collection('admin_users').doc(uid).get();
    if (!adminDoc.exists) {
      throw new functions.https.HttpsError(
        'not-found',
        'Admin user not found'
      );
    }

    // Delete from Firebase Auth
    await auth.deleteUser(uid);

    // Delete from Firestore
    await db.collection('admin_users').doc(uid).delete();

    return {
      success: true,
      message: 'Admin user deleted successfully',
    };
  } catch (error) {
    console.error('Error deleting admin user:', error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError(
      'internal',
      'Failed to delete admin user: ' + error.message
    );
  }
});
