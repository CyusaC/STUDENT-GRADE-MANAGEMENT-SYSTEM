SET SERVEROUTPUT ON;

DECLARE
    TYPE student_record IS RECORD (
        student_id    NUMBER(5),
        student_name  VARCHAR2(50),
        score         NUMBER(3),
        grade         VARCHAR2(2),
        status        VARCHAR2(20)
    );
    
    TYPE student_varray IS VARRAY(5) OF student_record;
    students_list student_varray := student_varray();
    
    TYPE grade_count_array IS TABLE OF NUMBER INDEX BY VARCHAR2(2);
    grade_statistics grade_count_array;
    
    TYPE name_table IS TABLE OF VARCHAR2(50);
    honor_roll name_table := name_table();
    
    v_student        student_record;
    v_total_students NUMBER := 0;
    v_avg_score      NUMBER := 0;
    v_error_flag     BOOLEAN := FALSE;
    v_grade_letter   VARCHAR2(2);
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('STUDENT GRADE MANAGEMENT SYSTEM');
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('');
    
    students_list.EXTEND(5);
    
    students_list(1).student_id := 101;
    students_list(1).student_name := 'Alice Johnson';
    students_list(1).score := 92;
    
    students_list(2).student_id := 102;
    students_list(2).student_name := 'Bob Smith';
    students_list(2).score := 78;
    
    students_list(3).student_id := 103;
    students_list(3).student_name := 'Charlie Brown';
    students_list(3).score := 85;
    
    students_list(4).student_id := 104;
    students_list(4).student_name := 'Diana Prince';
    students_list(4).score := 95;
    
    students_list(5).student_id := 105;
    students_list(5).student_name := 'Ethan Hunt';
    students_list(5).score := 65;
    
    grade_statistics('A') := 0;
    grade_statistics('B') := 0;
    grade_statistics('C') := 0;
    grade_statistics('D') := 0;
    grade_statistics('F') := 0;
    
    DBMS_OUTPUT.PUT_LINE('PROCESSING STUDENT RECORDS...');
    DBMS_OUTPUT.PUT_LINE('');
    
    <<process_students>>
    FOR i IN 1..students_list.COUNT LOOP
        v_student := students_list(i);
        v_total_students := v_total_students + 1;
        
        IF v_student.score < 0 OR v_student.score > 100 THEN
            v_error_flag := TRUE;
            GOTO error_handler;
        END IF;
        
        <<calculate_grade>>
        IF v_student.score >= 90 THEN
            v_student.grade := 'A';
            v_student.status := 'Excellent';
            honor_roll.EXTEND;
            honor_roll(honor_roll.LAST) := v_student.student_name;
        ELSIF v_student.score >= 80 THEN
            v_student.grade := 'B';
            v_student.status := 'Good';
        ELSIF v_student.score >= 70 THEN
            v_student.grade := 'C';
            v_student.status := 'Average';
        ELSIF v_student.score >= 60 THEN
            v_student.grade := 'D';
            v_student.status := 'Below Average';
        ELSE
            v_student.grade := 'F';
            v_student.status := 'Failing';
            GOTO alert_failing;
        END IF;
        
        grade_statistics(v_student.grade) := grade_statistics(v_student.grade) + 1;
        
        <<display_result>>
        DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_student.student_id);
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_student.student_name);
        DBMS_OUTPUT.PUT_LINE('Score: ' || v_student.score);
        DBMS_OUTPUT.PUT_LINE('Grade: ' || v_student.grade);
        DBMS_OUTPUT.PUT_LINE('Status: ' || v_student.status);
        DBMS_OUTPUT.PUT_LINE('---');
        
        students_list(i) := v_student;
        
        GOTO continue_processing;
        
        <<alert_failing>>
        DBMS_OUTPUT.PUT_LINE('*** ALERT: FAILING STUDENT ***');
        DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_student.student_id);
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_student.student_name);
        DBMS_OUTPUT.PUT_LINE('Score: ' || v_student.score);
        DBMS_OUTPUT.PUT_LINE('Grade: ' || v_student.grade);
        DBMS_OUTPUT.PUT_LINE('Recommend: Academic counseling required');
        DBMS_OUTPUT.PUT_LINE('---');
        
        grade_statistics(v_student.grade) := grade_statistics(v_student.grade) + 1;
        students_list(i) := v_student;
        
        <<continue_processing>>
        NULL;
        
    END LOOP process_students;
    
    GOTO statistics_section;
    
    <<error_handler>>
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('*** ERROR DETECTED ***');
    DBMS_OUTPUT.PUT_LINE('Invalid score found for Student ID: ' || v_student.student_id);
    DBMS_OUTPUT.PUT_LINE('Score must be between 0 and 100');
    DBMS_OUTPUT.PUT_LINE('');
    GOTO end_program;
    
    <<statistics_section>>
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('GRADE DISTRIBUTION STATISTICS');
    DBMS_OUTPUT.PUT_LINE('======================================');
    
    v_grade_letter := 'A';
    LOOP
        DBMS_OUTPUT.PUT_LINE('Grade ' || v_grade_letter || ': ' || 
                           grade_statistics(v_grade_letter) || ' student(s)');
        
        EXIT WHEN v_grade_letter = 'F';
        CASE v_grade_letter
            WHEN 'A' THEN v_grade_letter := 'B';
            WHEN 'B' THEN v_grade_letter := 'C';
            WHEN 'C' THEN v_grade_letter := 'D';
            WHEN 'D' THEN v_grade_letter := 'F';
        END CASE;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('HONOR ROLL (Grade A Students)');
    DBMS_OUTPUT.PUT_LINE('======================================');
    
    IF honor_roll.COUNT > 0 THEN
        FOR j IN 1..honor_roll.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(j || '. ' || honor_roll(j));
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('No students achieved Grade A');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('COLLECTION METHODS DEMONSTRATION');
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('Total students (COUNT): ' || students_list.COUNT);
    DBMS_OUTPUT.PUT_LINE('First index (FIRST): ' || students_list.FIRST);
    DBMS_OUTPUT.PUT_LINE('Last index (LAST): ' || students_list.LAST);
    DBMS_OUTPUT.PUT_LINE('Collection LIMIT: ' || students_list.LIMIT);
    DBMS_OUTPUT.PUT_LINE('Honor roll size: ' || honor_roll.COUNT);
    
    <<end_program>>
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('======================================');
    DBMS_OUTPUT.PUT_LINE('PROGRAM EXECUTION COMPLETED');
    DBMS_OUTPUT.PUT_LINE('======================================');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected Error: ' || SQLERRM);
END;
/
