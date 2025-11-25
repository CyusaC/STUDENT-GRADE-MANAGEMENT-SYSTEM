# Student Grade Management System

## 📋 Project Overview

A comprehensive PL/SQL program demonstrating the use of **Collections**, **Records**, and **GOTO statements** through a practical student grade management system. This project processes student data, calculates grades, generates statistics, and maintains an honor roll.

## 🎯 Learning Objectives

This project demonstrates:
- **PL/SQL Records**: Composite data types grouping related student information
- **PL/SQL Collections**: 
  - VARRAYs (bounded arrays)
  - Nested Tables (unbounded collections)
  - Associative Arrays (index-by tables)
- **GOTO Statements**: Flow control for error handling and special conditions
- **Collection Methods**: COUNT, EXTEND, FIRST, LAST, LIMIT

## 🚀 Features

- ✅ Store and process multiple student records
- ✅ Automatic grade calculation based on scores
- ✅ Grade distribution statistics (A, B, C, D, F)
- ✅ Honor roll generation for top performers
- ✅ Error handling using GOTO statements
- ✅ Alerts for failing students requiring intervention
- ✅ Collection methods demonstration

## 📊 Grade Scale

| Score Range | Grade | Status |
|-------------|-------|--------|
| 90-100 | A | Excellent |
| 80-89 | B | Good |
| 70-79 | C | Average |
| 60-69 | D | Below Average |
| 0-59 | F | Failing |

## 🗂️ Project Structure

```
plsql-collections-records/
├── README.md                      # This file
├── student-grade-system.sql       # Main PL/SQL code
├── problem-statement.md           # Detailed problem description
├── documentation.md               # Complete documentation
└── screenshots/                   # Output screenshots
    ├── output-full.png
    ├── grade-statistics.png
    └── honor-roll.png
```

## 💻 How to Run

### Prerequisites
- Oracle Database (11g or higher)
- SQL*Plus, SQL Developer, or Oracle Live SQL

### Execution Steps

1. **Open your Oracle SQL environment**
   ```bash
   sqlplus username/password@database
   ```

2. **Enable server output** (Required to see results)
   ```sql
   SET SERVEROUTPUT ON;
   ```

3. **Load and execute the script**
   ```sql
   @student-grade-system.sql
   ```
   
   OR copy and paste the code from `student-grade-system.sql` and press **F5** or click **Run**

4. **View the output** in the console

## 📝 Code Highlights

### Record Definition
```sql
TYPE student_record IS RECORD (
    student_id    NUMBER(5),
    student_name  VARCHAR2(50),
    score         NUMBER(3),
    grade         VARCHAR2(2),
    status        VARCHAR2(20)
);
```

### Collections Used

1. **VARRAY** - Fixed size array for student list
   ```sql
   TYPE student_varray IS VARRAY(5) OF student_record;
   ```

2. **Associative Array** - Grade statistics counter
   ```sql
   TYPE grade_count_array IS TABLE OF NUMBER INDEX BY VARCHAR2(2);
   ```

3. **Nested Table** - Dynamic honor roll list
   ```sql
   TYPE name_table IS TABLE OF VARCHAR2(50);
   ```

### GOTO Usage

- `<<error_handler>>` - Handles invalid score entries
- `<<alert_failing>>` - Special processing for failing students
- `<<continue_processing>>` - Resumes normal flow after alerts
- `<<statistics_section>>` - Skips error handler when no errors

## 📈 Sample Output

```
======================================
STUDENT GRADE MANAGEMENT SYSTEM
======================================

PROCESSING STUDENT RECORDS...

Student ID: 101
Name: Alice Johnson
Score: 92
Grade: A
Status: Excellent
---

Student ID: 102
Name: Bob Smith
Score: 78
Grade: C
Status: Average
---

======================================
GRADE DISTRIBUTION STATISTICS
======================================
Grade A: 2 student(s)
Grade B: 1 student(s)
Grade C: 1 student(s)
Grade D: 0 student(s)
Grade F: 1 student(s)

======================================
HONOR ROLL (Grade A Students)
======================================
1. Alice Johnson
2. Diana Prince
```

## 🔧 Customization

You can modify the code to:
- Change the number of students (modify VARRAY size)
- Add more fields to the record (email, phone, etc.)
- Adjust the grading scale thresholds
- Add additional statistics or reports
- Implement different GOTO scenarios

## 📚 Key Concepts Demonstrated

### 1. Records
Groups related data into a single composite structure, making code cleaner and more maintainable.

### 2. Collections
- **VARRAY**: Best for fixed-size lists where size is known in advance
- **Nested Table**: Ideal for dynamic lists that grow/shrink
- **Associative Array**: Perfect for key-value pair lookups

### 3. GOTO Statements
While generally discouraged, GOTO is useful for:
- Breaking out of deeply nested loops
- Error handling and recovery
- Performance optimization in specific scenarios

## ⚠️ Important Notes

- The program processes exactly 5 students (VARRAY limit)
- Scores must be between 0-100 (validated with error handling)
- Server output must be enabled to see results
- All data is processed in memory (no database tables created)

## 🎓 Academic Context

This project was created as a demonstration for database programming coursework, specifically focusing on PL/SQL advanced features including collections, composite types, and control flow statements.

## 👨‍💻 Author

**[Your Name]**  
Student ID: [Your ID]  
Course: [Your Course Name]  
Date: November 2025

## 📄 License

This project is created for educational purposes.

## 🤝 Contributing

This is an academic project. Contributions are not accepted, but feel free to fork and modify for your own learning.

## 📞 Contact

For questions or clarifications, please contact through the course instructor.

---

**Note**: This project demonstrates PL/SQL concepts for academic assessment. All code has been tested and runs successfully in Oracle Database environments.
