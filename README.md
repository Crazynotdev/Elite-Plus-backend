***BACKEND STRUCTURE***

```
eliteplus-backend/
├─ config/
│  └─ db.js
├─ middleware/
│  ├─ auth.js
│  └─ requireRole.js
├─ controllers/
│  ├─ authController.js
│  ├─ userController.js
│  ├─ classController.js
│  ├─ subjectController.js
│  ├─ gradeController.js
│  ├─ attendanceController.js
│  ├─ timetableController.js
│  ├─ messageController.js
│  ├─ announcementController.js
│  ├─ feeController.js
│  └─ disciplineController.js
├─ routes/
│  ├─ auth.js
│  ├─ users.js
│  ├─ classes.js
│  ├─ subjects.js
│  ├─ grades.js
│  ├─ attendance.js
│  ├─ timetable.js
│  ├─ messages.js
│  ├─ announcements.js
│  ├─ fees.js
│  └─ discipline.js
├─ seeds/
│  └─ create-admin.js
├─ database/
│  └─ schema.sql
├─ utils/
│  └─ passwords.js
├─ server.js
└─ .env
```
