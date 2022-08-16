--Deliverable 1 
--Create table with titles
Select e.emp_no, 
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

-- Employee count by title
SELECT COUNT(title), title
-- INTO title_count
FROM unique_titles
GROUP BY title
ORDER BY count DESC;


--Deliverable 2

Select DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibilty 
FROM employees AS e
INNER JOIN dept_employees AS de
ON e.emp_no = de.emp_no
INNER JOIN titles AS ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' 
	   AND '1965-12-31') 
	   AND de.to_date = ('9999-01-01')
ORDER BY e.emp_no ASC;



--Deliverable 3

-- Employee count by title
SELECT COUNT(emp_no), title
INTO title_count_mentorship
FROM mentorship_eligibilty
GROUP BY title
ORDER BY count DESC;

-- Mergeing Charts and removing duplicates
SELECT DISTINCT ON(ut.emp_no) COUNT(ut.title),
	de.dept_no,
	ut.title
INTO dept_count_dupicates
FROM unique_titles AS ut
LEFT JOIN dept_employees AS de
ON ut.emp_no = de.emp_no
GROUP BY dept_no, title, ut.emp_no
ORDER BY ut.emp_no DESC;

-- title count by department by title
SELECT COUNT(title), dept_no, title
INTO dept_title_count
FROM dept_count_dupicates
GROUP BY dept_no, title
ORDER BY count DESC;
