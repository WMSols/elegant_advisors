const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');

admin.initializeApp();

const db = admin.firestore();
const auth = admin.auth();

// Email configuration
// Set these as environment variables in Google Cloud Console:
// SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASSWORD, EMAIL_FROM, EMAIL_FROMNAME, EMAIL_ADMIN
const getEmailConfig = () => {
  const smtpHost = process.env.SMTP_HOST;
  const smtpPort = process.env.SMTP_PORT;
  const smtpUser = process.env.SMTP_USER;
  const smtpPassword = process.env.SMTP_PASSWORD;
  const emailFrom = process.env.EMAIL_FROM;
  const emailFromName = process.env.EMAIL_FROMNAME;
  const emailAdmin = process.env.EMAIL_ADMIN;

  if (!smtpHost || !smtpPort || !smtpUser || !smtpPassword || !emailFrom) {
    throw new Error(
      'Email configuration not set. Please set environment variables in Google Cloud Console: ' +
      'SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASSWORD, EMAIL_FROM, EMAIL_FROMNAME, EMAIL_ADMIN'
    );
  }

  return {
    host: smtpHost,
    port: parseInt(smtpPort, 10),
    user: smtpUser,
    pass: smtpPassword,
    from: emailFromName 
      ? `${emailFromName} <${emailFrom}>`
      : emailFrom,
    admin: emailAdmin || emailFrom,
  };
};

// Create reusable transporter
const createTransporter = () => {
  const emailConfig = getEmailConfig();
  return nodemailer.createTransport({
    host: emailConfig.host,
    port: emailConfig.port,
    secure: emailConfig.port === 465, // true for 465 (SSL), false for other ports (TLS)
    auth: {
      user: emailConfig.user,
      pass: emailConfig.pass,
    },
    tls: {
      // Do not fail on invalid certificates
      rejectUnauthorized: false,
    },
  });
};

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

/**
 * Send inquiry notification email to admin
 * Requires: { inquiry, property }
 * Public callable (no auth required for contact form submissions)
 */
exports.sendInquiryNotification = functions.https.onCall(async (data, context) => {
  try {
    const { inquiry, property } = data;

    // Validate input
    if (!inquiry || !inquiry.email || !inquiry.message) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Inquiry data is required'
      );
    }

    const emailConfig = getEmailConfig();
    const transporter = createTransporter();

    // Format inquiry details
    const propertyInfo = property
      ? `
      <h3>Property Details:</h3>
      <p><strong>Title:</strong> ${property.title || 'N/A'}</p>
      <p><strong>Location:</strong> ${property.location?.city || 'N/A'}, ${property.location?.country || 'N/A'}</p>
      <p><strong>Price:</strong> ${property.price?.amount ? `${property.price.currency || 'EUR'} ${property.price.amount.toLocaleString()}` : 'Price on Request'}</p>
      <p><a href="${property.slug ? `https://elegantadvisors.com/properties/${property.slug}` : '#'}">View Property</a></p>
    `
      : '<p><em>General inquiry (not property-specific)</em></p>';

    const emailHtml = `
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <style>
            body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
            .container { max-width: 600px; margin: 0 auto; padding: 20px; }
            .header { background-color: #2c3e50; color: white; padding: 20px; text-align: center; }
            .content { background-color: #f9f9f9; padding: 20px; margin-top: 20px; }
            .field { margin-bottom: 15px; }
            .label { font-weight: bold; color: #555; }
            .value { margin-top: 5px; }
            .footer { margin-top: 20px; padding-top: 20px; border-top: 1px solid #ddd; font-size: 12px; color: #777; }
          </style>
        </head>
        <body>
          <div class="container">
            <div class="header">
              <h1>New Contact Inquiry</h1>
            </div>
            <div class="content">
              <div class="field">
                <div class="label">Name:</div>
                <div class="value">${inquiry.name || 'N/A'}</div>
              </div>
              <div class="field">
                <div class="label">Email:</div>
                <div class="value"><a href="mailto:${inquiry.email}">${inquiry.email}</a></div>
              </div>
              <div class="field">
                <div class="label">Phone:</div>
                <div class="value">${inquiry.phone || 'N/A'}</div>
              </div>
              <div class="field">
                <div class="label">Subject:</div>
                <div class="value">${inquiry.subject || 'General Inquiry'}</div>
              </div>
              <div class="field">
                <div class="label">Message:</div>
                <div class="value">${inquiry.message.replace(/\n/g, '<br>')}</div>
              </div>
              ${propertyInfo}
              <div class="field">
                <div class="label">Submitted:</div>
                <div class="value">${new Date(inquiry.createdAt?.seconds * 1000 || Date.now()).toLocaleString()}</div>
              </div>
            </div>
            <div class="footer">
              <p>This email was sent from the Elegant Advisors contact form.</p>
            </div>
          </div>
        </body>
      </html>
    `;

    const emailText = `
New Contact Inquiry

Name: ${inquiry.name || 'N/A'}
Email: ${inquiry.email}
Phone: ${inquiry.phone || 'N/A'}
Subject: ${inquiry.subject || 'General Inquiry'}

Message:
${inquiry.message}

${property ? `Property: ${property.title || 'N/A'}` : 'General inquiry (not property-specific)'}

Submitted: ${new Date(inquiry.createdAt?.seconds * 1000 || Date.now()).toLocaleString()}
    `;

    // Send email
    const mailOptions = {
      from: emailConfig.from,
      to: emailConfig.admin,
      subject: `New Inquiry: ${inquiry.subject || 'General Inquiry'} - ${inquiry.name || 'Unknown'}`,
      text: emailText,
      html: emailHtml,
      replyTo: inquiry.email, // Allow replying directly to the inquirer
    };

    await transporter.sendMail(mailOptions);

    return {
      success: true,
      message: 'Inquiry notification sent successfully',
    };
  } catch (error) {
    console.error('Error sending inquiry notification:', error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError(
      'internal',
      'Failed to send inquiry notification: ' + error.message
    );
  }
});

/**
 * Send confirmation email to user after inquiry submission
 * Requires: { inquiry }
 * Public callable (no auth required)
 */
exports.sendInquiryConfirmation = functions.https.onCall(async (data, context) => {
  try {
    const { inquiry } = data;

    // Validate input
    if (!inquiry || !inquiry.email) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Inquiry data with email is required'
      );
    }

    const emailConfig = getEmailConfig();
    const transporter = createTransporter();

    const emailHtml = `
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <style>
            body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
            .container { max-width: 600px; margin: 0 auto; padding: 20px; }
            .header { background-color: #2c3e50; color: white; padding: 20px; text-align: center; }
            .content { background-color: #f9f9f9; padding: 20px; margin-top: 20px; }
            .footer { margin-top: 20px; padding-top: 20px; border-top: 1px solid #ddd; font-size: 12px; color: #777; }
          </style>
        </head>
        <body>
          <div class="container">
            <div class="header">
              <h1>Thank You for Your Inquiry</h1>
            </div>
            <div class="content">
              <p>Dear ${inquiry.name || 'Valued Client'},</p>
              <p>Thank you for contacting Elegant Advisors. We have received your inquiry and will get back to you as soon as possible.</p>
              <p><strong>Your Inquiry Details:</strong></p>
              <ul>
                <li><strong>Subject:</strong> ${inquiry.subject || 'General Inquiry'}</li>
                <li><strong>Submitted:</strong> ${new Date(inquiry.createdAt?.seconds * 1000 || Date.now()).toLocaleString()}</li>
              </ul>
              <p>Our team typically responds within 24-48 hours. If you have any urgent questions, please don't hesitate to contact us directly.</p>
              <p>Best regards,<br>The Elegant Advisors Team</p>
            </div>
            <div class="footer">
              <p>This is an automated confirmation email. Please do not reply to this email.</p>
            </div>
          </div>
        </body>
      </html>
    `;

    const emailText = `
Thank You for Your Inquiry

Dear ${inquiry.name || 'Valued Client'},

Thank you for contacting Elegant Advisors. We have received your inquiry and will get back to you as soon as possible.

Your Inquiry Details:
- Subject: ${inquiry.subject || 'General Inquiry'}
- Submitted: ${new Date(inquiry.createdAt?.seconds * 1000 || Date.now()).toLocaleString()}

Our team typically responds within 24-48 hours. If you have any urgent questions, please don't hesitate to contact us directly.

Best regards,
The Elegant Advisors Team

---
This is an automated confirmation email. Please do not reply to this email.
    `;

    const mailOptions = {
      from: emailConfig.from,
      to: inquiry.email,
      subject: 'Thank You for Your Inquiry - Elegant Advisors',
      text: emailText,
      html: emailHtml,
    };

    await transporter.sendMail(mailOptions);

    return {
      success: true,
      message: 'Confirmation email sent successfully',
    };
  } catch (error) {
    console.error('Error sending confirmation email:', error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError(
      'internal',
      'Failed to send confirmation email: ' + error.message
    );
  }
});

/**
 * Send admin alert email
 * Requires: { subject, message, priority }
 * Admin-only callable
 */
exports.sendAdminAlert = functions.https.onCall(async (data, context) => {
  try {
    // Verify the caller is an admin
    await verifyAdmin(context);

    const { subject, message, priority } = data;

    // Validate input
    if (!subject || !message) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Subject and message are required'
      );
    }

    const emailConfig = getEmailConfig();
    const transporter = createTransporter();

    const priorityBadge = priority === 'high' ? '🔴 HIGH PRIORITY' : priority === 'medium' ? '🟡 MEDIUM PRIORITY' : '🟢 LOW PRIORITY';

    const emailHtml = `
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <style>
            body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
            .container { max-width: 600px; margin: 0 auto; padding: 20px; }
            .header { background-color: #e74c3c; color: white; padding: 20px; text-align: center; }
            .content { background-color: #f9f9f9; padding: 20px; margin-top: 20px; }
            .priority { background-color: #fff3cd; padding: 10px; margin: 10px 0; border-left: 4px solid #ffc107; }
          </style>
        </head>
        <body>
          <div class="container">
            <div class="header">
              <h1>Admin Alert</h1>
            </div>
            <div class="content">
              <div class="priority">
                <strong>${priorityBadge}</strong>
              </div>
              <h2>${subject}</h2>
              <p>${message.replace(/\n/g, '<br>')}</p>
              <p><small>Alert sent at: ${new Date().toLocaleString()}</small></p>
            </div>
          </div>
        </body>
      </html>
    `;

    const mailOptions = {
      from: emailConfig.from,
      to: emailConfig.admin,
      subject: `[Admin Alert] ${subject}`,
      text: `${priorityBadge}\n\n${subject}\n\n${message}\n\nAlert sent at: ${new Date().toLocaleString()}`,
      html: emailHtml,
    };

    await transporter.sendMail(mailOptions);

    return {
      success: true,
      message: 'Admin alert sent successfully',
    };
  } catch (error) {
    console.error('Error sending admin alert:', error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError(
      'internal',
      'Failed to send admin alert: ' + error.message
    );
  }
});
