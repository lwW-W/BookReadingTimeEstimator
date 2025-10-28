# book_reading_time_estimator_asg1_300827

Short README:
i)	App Name: Book Reading Time Estimator
Description: 
This Flutter application helps users estimate how many days it will take to finish reading a book. By entering the total number of pages, reading speed (pages per hour), and daily reading hours, the app calculates and displays the number of days needed to complete the book.

ii)	Input: 
-	Total number of pages
-	Reading speed (pages per hour)
-	Reading hours per day

Process: 
-	The app reads all input values from the text fields and drop down button.
-	It validates that all input values are positive numbers and that the reading hours per day are selected.
-	It calculates total reading hours using the formula:
totalHours = pages / speed
-	It calculates the number of days to finish the book using the formula:
days = totalHours / selectedHours

Output: 
-	Displays the estimated number of days required to finish reading the book, “You will finish in 5 days”.
-	If the input is invalid or incomplete, it shows an error message.


iii)	Widget List Used:
1.	Scaffold
2.	Center
3.	Column
4.	Image
5.	Text
6.	SizedBox
7.	AppBar
8.	SingleChildScrollView
9.	Container
10.	Padding
11.	Expanded
12.	TextField
13.	ElevatedButton
14.	Row
15.	DropdownButtonFormField
16.	CircularProgressIndicator

iv)	Basic Validation Approach
-	Each input is parsed using double.tryParse() to safely convert text input to a number.
-	If parsing fails (e.g. empty input or contains letter), the value defaults to 0.
-	Before calculation, the app checks whether the total pages and reading speed inputs are greater than 0, and ensures that the reading hours per day are selected from the dropdown menu.
-	If any invalid values exist, it shows an error message and stops the calculation.
-	The app then resets all previous error messages and result values inside setState() before starting a new validation cycle.
-	Only when all inputs are valid, the app proceeds to compute the result.