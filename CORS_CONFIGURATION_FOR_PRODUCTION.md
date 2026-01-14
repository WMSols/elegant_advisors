Step-by-step CORS configuration
Step 1: Get the correct bucket name
The bucket name in the URL (elegant-2b05d.firebasestorage.app) may differ from the GCS bucket name. Find it:
In Cloud Shell, run:
gsutil ls
Or check in Firebase Console:
Firebase Console → Storage → Files tab
Look for the bucket name (might be elegant-2b05d.appspot.com or similar)
Step 2: Create CORS configuration file
In Cloud Shell, create the CORS config file:

*******************************************
nano cors-production.json
Paste this (replace with your actual domain):

If your production domain is https://elegantadvisors.com:
[  {    "origin": [      "https://elegantadvisors.com",      "https://www.elegantadvisors.com",      "http://localhost:59919",      "http://localhost:*"    ],    "method": ["GET", "HEAD"],    "responseHeader": ["Content-Type", "Authorization"],    "maxAgeSeconds": 3600  }]
Note: "http://localhost:*" allows any localhost port for development.
Once you update CORS with your production domain, you should be set. The code changes (content-type detection and error handling) will work in production automatically.