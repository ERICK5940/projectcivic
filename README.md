# Civic Issues Reporting and Resolution System - Python Flask Application

A comprehensive web-based system for reporting, tracking, and resolving civic issues with role-based access control.

## Features

- **Multi-Role System**: Citizen, Municipal Officer, Department Official, Police Officer
- **Citizen Authentication**: OTP-based login via phone number
- **Official Authentication**: ID/Password login with department/pincode verification
- **Complaint Management**: Create, track, and update complaint status
- **Fake Complaint Investigation**: Police officers can report and investigate fake complaints
- **District-wise Classification**: Support for 38 Tamil Nadu districts
- **Responsive Design**: Works on desktop, tablet, and mobile devices
- **Real-time Status Updates**: Track complaint progress through resolution pipeline

## Project Structure

```
project civic issues/
├── app.py                 # Main Flask application
├── requirements.txt       # Python dependencies
├── README.md             # This file
├── civic_system.db       # SQLite database (auto-created)
└── templates/
    ├── index.html        # Login and role selection page
    └── dashboard.html    # Role-specific dashboards
```

## Installation

### 1. Clone or Download the Project
```bash
cd "d:\project civic issues"
```

### 2. Create a Virtual Environment (Recommended)
```bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

## Running the Application

### 1. Start the Flask Server
```bash
python app.py
```

The application will be available at: **http://localhost:5000**

### 2. Access the Application
Open your browser and navigate to `http://localhost:5000`

## Demo Credentials

### Citizen Login
- **Phone**: 9876543210 or 9876543211
- **Authentication**: OTP-based
  - Click "Get OTP"
  - Demo OTP will be displayed in the success message
  - Enter the OTP and verify

### Municipal Officer Login
- **User ID**: MUN001
- **Password**: password123
- **Pincode**: 600001

### Department Official Login
- **User ID**: DEPT001
- **Password**: password123
- **Department**: Municipal Corporation

### Police Officer Login
- **User ID**: POLICE001
- **Password**: password123

## API Endpoints

### Authentication
- `POST /api/citizen/request-otp` - Request OTP for citizen
- `POST /api/citizen/verify-otp` - Verify OTP and login
- `POST /api/official/login` - Officer login

### Complaints
- `GET /api/complaints` - Get complaints (role-based filtering)
- `POST /api/complaint/submit` - Submit new complaint
- `POST /api/complaint/<id>/verify` - Verify complaint (Municipal)
- `POST /api/complaint/<id>/assign` - Assign complaint (Municipal)
- `POST /api/complaint/<id>/resolve` - Resolve complaint (Department)
- `POST /api/complaint/<id>/report-fake` - Report fake complaint (Police)

## User Workflows

### Citizen Workflow
1. Login with OTP
2. Fill complaint form with:
   - Problem type (Roads, Water, Garbage, etc.)
   - District and pincode
   - Location and description
3. Submit complaint
4. Track complaint status in dashboard
5. View complaint updates as it moves through the system

### Municipal Officer Workflow
1. Login with ID/Password
2. Review submitted complaints
3. Verify authenticity and forward to appropriate department
4. Assign to Department Official

### Department Official Workflow
1. Login with ID/Password
2. View assigned complaints
3. Take action and upload proof of resolution
4. Update complaint status

### Police Officer Workflow
1. Login with ID/Password
2. Investigate flagged fake complaints
3. Document findings
4. Archive investigation records

## Database Models

### User
- id, phone (citizen), user_id (officer), password
- role, name, department, pincode
- created_at, relationships to complaints

### Complaint
- complaint_id, title, type, description
- district, pincode, location, coordinates
- status (submitted, verified, assigned, resolved)
- reporter_id, verified_by, assigned_to
- evidence_path, priority
- created_at, updated_at, resolved_at

### OTP
- phone, otp_code, expires_at
- For 10-minute validation window

### FakeInvestigation
- complaint_id, investigated_by
- reason, evidence, created_at

## Customization

### Adding Districts
Edit the `get_districts()` function in `app.py` to add or remove districts.

### Changing Secret Key
Replace `'your-secret-key-here-change-in-production'` in `app.py` with a strong secret key.

### SMS Integration
Replace the OTP print statement in `request_otp()` with actual SMS gateway API calls.

### Database
Use SQLite by default. To change:
```python
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://user:password@localhost/dbname'
```

## Security Notes

⚠️ **Important for Production**:
1. Change the SECRET_KEY to a strong random value
2. Use environment variables for sensitive data
3. Enable HTTPS/SSL
4. Implement rate limiting for OTP requests
5. Use actual SMS gateway for OTP delivery
6. Add CSRF protection
7. Implement proper password hashing for all user types
8. Add input validation and sanitization

## Troubleshooting

### Port 5000 Already in Use
```bash
python app.py --port 5001
```

### Database Issues
Delete `civic_system.db` and restart the app to recreate the database:
```bash
rm civic_system.db
python app.py
```

### Import Errors
Ensure all packages from requirements.txt are installed:
```bash
pip install --upgrade -r requirements.txt
```

## Development Tips

- Enable Flask debug mode by setting `debug=True` in `app.run()` (already enabled)
- Use browser DevTools to inspect API requests
- Check Flask console for detailed error messages
- Database explorer: Use DB Browser for SQLite to view data

## Future Enhancements

- Email notifications for status updates
- File upload for evidence
- Mobile app version
- Admin dashboard
- Analytics and reporting
- Google Maps integration for location
- Real SMS/email notifications
- Two-factor authentication
- Complaint escalation system
- Performance metrics dashboard

## License

This project is created for demonstration purposes.

## Support

For issues or questions, review the Flask-SQLAlchemy documentation at:
- Flask: https://flask.palletsprojects.com/
- SQLAlchemy: https://www.sqlalchemy.org/
