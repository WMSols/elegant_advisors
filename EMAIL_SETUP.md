# Email Service Setup Guide

The email service is configured to use Firebase Cloud Functions with Nodemailer and environment variables from Google Cloud Console.

## Prerequisites

1. An email account with SMTP access (Gmail, custom domain, etc.)
2. Firebase CLI installed and configured
3. Functions deployed to Firebase
4. Access to Google Cloud Console

## Setup Steps

### 1. Install Dependencies

Navigate to the `functions` directory and install the required packages:

```bash
cd functions
npm install
```

### 2. Configure Email Settings in Google Cloud Console

**Method: Using Google Cloud Console (Recommended)**

1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Select your Firebase project
3. Navigate to **Cloud Functions** → Select your function (or create one)
4. Go to the **Runtime, build, connections and security settings** tab
5. Scroll down to **Environment variables** section
6. Click **Add Variable** and add the following environment variables:

| Variable Name | Example Value | Description |
|--------------|---------------|-------------|
| `SMTP_HOST` | `mail.wmsols.com` | Your SMTP server hostname |
| `SMTP_PORT` | `465` | SMTP port (465 for SSL, 587 for TLS) |
| `SMTP_USER` | `test@wmsols.com` | SMTP username (usually your email) |
| `SMTP_PASSWORD` | `YourPassword123` | SMTP password |
| `EMAIL_FROM` | `test@wmsols.com` | Sender email address |
| `EMAIL_FROMNAME` | `Elegant Advisors` | Display name for sender |
| `EMAIL_ADMIN` | `admin@elegantadvisors.com` | Admin email for notifications |

**Example Configuration:**
```
SMTP_HOST = mail.wmsols.com
SMTP_PORT = 465
SMTP_USER = test@wmsols.com
SMTP_PASSWORD = WMSols@2025
EMAIL_FROM = test@wmsols.com
EMAIL_FROMNAME = Elegant Advisors
EMAIL_ADMIN = admin@elegantadvisors.com
```

7. Click **Save** or **Deploy** to apply changes

**Important Notes:**
- Port `465` uses SSL (secure: true)
- Port `587` uses TLS (secure: false, requires STARTTLS)
- For Gmail, use an **App Password**, not your regular password
- Make sure your SMTP server allows connections from Google Cloud

### 3. Deploy Functions

Deploy the updated functions to Firebase:

```bash
firebase deploy --only functions
```

Or if you configured via Console, the function will redeploy automatically.

### 4. Verify Configuration

After deployment, test the email service by submitting a contact form. Check:
- Admin receives inquiry notification emails
- Users receive confirmation emails (if enabled)
- Check Firebase Functions logs for any errors

## Email Functions

The following Cloud Functions are available:

1. **sendInquiryNotification** - Sends notification to admin when a contact form is submitted
2. **sendInquiryConfirmation** - Sends confirmation email to the user
3. **sendAdminAlert** - Sends admin alerts (requires admin authentication)

## Using Different SMTP Providers

The configuration supports any SMTP provider. Here are common settings:

### Gmail
```
SMTP_HOST = smtp.gmail.com
SMTP_PORT = 465
SMTP_USER = your-email@gmail.com
SMTP_PASSWORD = your-app-password
EMAIL_FROM = your-email@gmail.com
EMAIL_FROMNAME = Elegant Advisors
```

### Custom Domain (like wmsols.com)
```
SMTP_HOST = mail.wmsols.com
SMTP_PORT = 465
SMTP_USER = test@wmsols.com
SMTP_PASSWORD = YourPassword
EMAIL_FROM = test@wmsols.com
EMAIL_FROMNAME = Elegant Advisors
```

### SendGrid
```
SMTP_HOST = smtp.sendgrid.net
SMTP_PORT = 587
SMTP_USER = apikey
SMTP_PASSWORD = your-sendgrid-api-key
EMAIL_FROM = your-verified-email@domain.com
EMAIL_FROMNAME = Elegant Advisors
```

### Mailgun
```
SMTP_HOST = smtp.mailgun.org
SMTP_PORT = 587
SMTP_USER = your-mailgun-username
SMTP_PASSWORD = your-mailgun-password
EMAIL_FROM = your-verified-email@domain.com
EMAIL_FROMNAME = Elegant Advisors
```

## Troubleshooting

### Emails Not Sending

1. **Check Firebase Functions Logs:**
   ```bash
   firebase functions:log
   ```
   Or in Google Cloud Console: **Cloud Functions** → Your function → **Logs**

2. **Verify Environment Variables:**
   - Go to Google Cloud Console
   - Navigate to your Cloud Function
   - Check **Runtime, build, connections and security settings** → **Environment variables**
   - Ensure all required variables are set

3. **Common Issues:**
   - SMTP credentials incorrect
   - SMTP server blocking connections from Google Cloud IPs
   - Firewall/network restrictions
   - Wrong port number (use 465 for SSL, 587 for TLS)
   - SMTP server requires authentication but credentials are wrong

### Testing Locally

You can test functions locally using the Firebase emulator:

1. Set environment variables locally:
   ```bash
   # Windows PowerShell
   $env:SMTP_HOST="mail.wmsols.com"
   $env:SMTP_PORT="465"
   $env:SMTP_USER="test@wmsols.com"
   $env:SMTP_PASSWORD="YourPassword"
   $env:EMAIL_FROM="test@wmsols.com"
   $env:EMAIL_FROMNAME="Elegant Advisors"
   $env:EMAIL_ADMIN="admin@elegantadvisors.com"
   ```

2. Start emulator:
   ```bash
   firebase emulators:start --only functions
   ```

3. Test the function from your app pointing to the emulator.

## Security Notes

- Never commit email passwords to version control
- Use Google Cloud Console environment variables for sensitive data
- Regularly rotate passwords
- Use strong, unique passwords for SMTP accounts
- Consider using service accounts with limited permissions

## Cost Considerations

- Firebase Functions: Free tier includes 2 million invocations/month
- Email sending: Depends on your email provider
  - Custom SMTP: Usually free with your hosting/email plan
  - Gmail: Free (with daily limits ~500 emails/day)
  - SendGrid: Free tier includes 100 emails/day
  - Mailgun: Free tier includes 5,000 emails/month

## Quick Reference: Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `SMTP_HOST` | ✅ Yes | SMTP server hostname |
| `SMTP_PORT` | ✅ Yes | SMTP port (465 or 587) |
| `SMTP_USER` | ✅ Yes | SMTP username |
| `SMTP_PASSWORD` | ✅ Yes | SMTP password |
| `EMAIL_FROM` | ✅ Yes | Sender email address |
| `EMAIL_FROMNAME` | ❌ No | Display name (defaults to EMAIL_FROM) |
| `EMAIL_ADMIN` | ❌ No | Admin email (defaults to EMAIL_FROM) |
