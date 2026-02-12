# 🏢 Elegant Real Estate

> **Flutter Web Application** for Elegant Real Estate - A leading real estate advisory platform in Portugal

---

## 🚀 Overview

Elegant Real Estate is a comprehensive real estate management platform built with Flutter Web, providing both client-facing property browsing and a powerful admin dashboard for managing properties, inquiries, and administrative tasks.

---

## 🛠️ Tech Stack

| Category | Technologies |
|----------|-------------|
| **Framework** | 🎯 Flutter Web |
| **State Management** | 📦 GetX |
| **Backend** | 🔥 Firebase (Firestore, Auth, Storage, Analytics, Functions) |
| **UI Libraries** | 🎨 Iconsax, Font Awesome, Lottie Animations |
| **Charts & Visualization** | 📊 FL Chart |
| **Maps** | 🗺️ Flutter Map, OpenStreetMap |
| **Image Handling** | 🖼️ Cached Network Image, Image Picker |

---

## ✨ Features

### 🔐 Admin Panel

#### 🔑 Authentication & Security
- **Secure Login System** - Firebase Authentication with email/password
- **Admin Role Management** - Role-based access control
- **Session Management** - Protected routes with middleware

#### 📊 Dashboard
- **Analytics Overview** - Real-time statistics and insights
- **Visitor Tracking** - Daily visitor analytics
- **Quick Actions** - Fast access to key features

#### 🏘️ Properties Management
- **Full CRUD Operations** - Create, Read, Update, Delete properties
- **Advanced Filtering** - Filter by status, published state, featured properties
- **Smart Search** - Real-time property search
- **Sorting Options** - Sort by title, date, price, status
- **Publish Control** - Publish/unpublish properties
- **Featured Properties** - Mark properties as featured
- **Image Management** - Upload, compress, and manage property images
- **Location Integration** - OpenStreetMap location search and mapping
- **Property Details** - Comprehensive property information management

#### 📧 Inquiries Management
- **Inquiry Dashboard** - View all contact submissions
- **Status Management** - Track inquiry status (new, read, replied, archived)
- **Reply System** - Send email replies directly from the platform
- **Property Linking** - Link inquiries to specific properties
- **Advanced Filters** - Filter by status, date, property
- **Export Functionality** - Export inquiries to CSV/TSV format
- **IP Tracking** - Track visitor IP addresses for analytics

#### 👥 Admin User Management
- **Create Admins** - Add new admin users via Cloud Functions
- **Edit Admins** - Update admin user information
- **Delete Admins** - Remove admin users securely
- **Admin List** - View all admin users

### 🌐 Client Portal

#### 🏠 Properties Browsing
- **Property Listings** - Browse all available properties
- **Advanced Filters** - Filter by location, price, status, features
- **Search Functionality** - Search properties by keywords
- **Property Cards** - Beautiful property cards with images and key details
- **Responsive Design** - Optimized for all screen sizes

#### 📋 Property Details
- **Detailed View** - Comprehensive property information
- **Image Gallery** - Multiple property images with gallery view
- **Location Map** - Interactive map showing property location
- **Property Specs** - Detailed specifications and features
- **Price Information** - Price details and currency display
- **Contact Integration** - Direct inquiry option from property page

#### 📬 Contact System
- **Contact Form** - Submit inquiries and questions
- **Property-Specific Inquiries** - Link inquiries to specific properties
- **My Contacts** - View submitted contact forms
- **Email Notifications** - Automatic email notifications

---

## 🔧 Services & Infrastructure

### 📡 Backend Services

#### 🔥 Firebase Services
- **Firestore** - NoSQL database for properties, inquiries, and admin data
- **Firebase Auth** - Secure authentication system
- **Firebase Storage** - Image and file storage
- **Firebase Analytics** - User behavior tracking and analytics
- **Cloud Functions** - Serverless backend functions for email, admin creation

#### 📧 Email Service
- **Inquiry Notifications** - Email alerts for new inquiries
- **Reply System** - Send replies to inquiries via email
- **Confirmation Emails** - Auto-confirmations for users
- **Admin Alerts** - System alerts and notifications

#### 📊 Analytics Service
- **Page View Tracking** - Track page visits
- **Property View Analytics** - Monitor property popularity
- **Contact Submission Tracking** - Track inquiry submissions
- **Custom Events** - Track custom user interactions

#### 📤 Export Service
- **CSV Export** - Export inquiries to CSV format
- **TSV Export** - Export inquiries to Excel-compatible TSV format
- **Data Formatting** - Properly formatted export data

#### 🗺️ Location Services
- **Location Search** - OpenStreetMap Nominatim integration
- **Reverse Geocoding** - Convert coordinates to addresses
- **Address Autocomplete** - Smart location suggestions

#### 🖼️ Image Services
- **Image Upload** - Secure image upload to Firebase Storage
- **Image Management** - Organize and manage property images

---

## 📁 Project Structure

```
lib/
├── core/                    # Core utilities and base classes
│   ├── app/                 # App initialization and routing
│   ├── constants/           # App constants
│   ├── theme/               # App theming
│   ├── utils/               # Utility functions
│   └── widgets/             # Reusable widgets
├── data/                    # Data layer
│   ├── services/            # Backend services
│   └── repositories/        # Data repositories
├── domain/                  # Domain layer
│   └── models/              # Data models
└── presentation/            # UI layer
    ├── admin/               # Admin panel
    │   ├── controllers/     # Admin controllers
    │   ├── screens/         # Admin screens
    │   └── widgets/         # Admin widgets
    └── client/              # Client portal
        ├── controllers/     # Client controllers
        ├── screens/         # Client screens
        └── widgets/         # Client widgets
```

## 🔒 Security

- **Firestore Security Rules** - Role-based access control
- **Storage Security Rules** - Protected file uploads
- **Authentication Middleware** - Protected admin routes
- **IP Tracking** - Visitor analytics and security

---

## 📝 License

This project is private and proprietary.

---

## 👨‍💻 Development

Built with ❤️ using Flutter Web and Firebase
