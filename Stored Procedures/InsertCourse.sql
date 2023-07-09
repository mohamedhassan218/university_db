CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertCourse`(
	IN p_c_name VARCHAR(150),
    IN p_c_lectures_number INT,
    IN p_minimum_lectures INT,
    IN p_d_ID INT,
    IN p_i_ID INT,
    IN p_academic_year INT,
    OUT msg VARCHAR(200)
)
BEGIN
	DECLARE duplicates INT;
    DECLARE D_ID INT;
    DECLARE I_ID INT;
    DECLARE A_ID INT;
    
    SELECT COUNT(*) INTO duplicates FROM course
    WHERE p_c_name = course_name;
    
    SELECT COUNT(*) INTO D_ID FROM department
    WHERE department_ID = p_d_ID;
    
    SELECT COUNT(*) INTO I_ID FROM instructor
    WHERE instructor_ID = p_i_ID;
    
    SELECT COUNT(*) INTO A_ID FROM academic_year
    WHERE year_ID = p_academic_year;
    
    IF duplicates > 0 THEN
		SET msg = 'Course is already exist.';
	ELSEIF p_c_lectures_number < p_minimum_lectures OR p_minimum_lectures < 0 OR p_c_lectures_number < 0 THEN
		SET msg = 'Please enter the number of lectures and minimum number of lectures correctly.';
    ELSEIF D_ID = 0 THEN
		SET msg = 'Department is not found.';
	ELSEIF A_ID = 0 THEN
		SET msg = 'Academic year is not found.';
	ELSEIF I_ID = 0 THEN
		SET msg = 'Instructor is not found.';
	ELSE 
		INSERT INTO course (course_name, lectures_number, minimum_lectures, d_ID, i_ID, academic_year)
        VALUES (p_c_name, p_c_lectures_number, p_minimum_lectures, p_d_ID, p_i_ID, p_academic_year);
        SET msg = 'Course is inserted successfully.';
	END IF;
END