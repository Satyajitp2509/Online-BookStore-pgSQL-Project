DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


 -- Q1 Retrieve all books in the "Fiction" genre:
 	select * from Books where genre='Fiction';

-- Q2 Find books published after the year 1950:
	select * from Books where Published_Year >1950;

-- Q3 List all customers from the Canada:
	select * from Customers where country='Canada'

-- Q4 Show orders placed in November 2023:
	select * from Orders where Order_Date>'2023-11-01' and Order_Date<'2023-11-30';

-- Q5 Retrieve the total stock of books available:
	select sum(Stock) as avaiable_stock from Books;

-- Q6 Find the details of the most expensive book:
	select * from Books order by price DESC limit 1;

-- Q7 Show all customers who ordered more than 1 quantity of a book:
	select * from Orders where quantity>1;
	
-- Q8 Retrieve all orders where the total amount exceeds $20:
	select * from orders where total_amount>20;

-- Q9 List all genres available in the Books table:	
	SELECT DISTINCT genre FROM Books;

-- Q10 Find the book with the lowest stock:
	select * from books order by stock ASC limit 1;

-- Q11 Calculate the total revenue generated from all orders:
	select sum(Total_Amount) as total_revenue from Orders;


-- Advanced

	-- Q1 Retrieve the total number of books sold for each genre:
	select * from orders;
	select * from books;
	select * from customers;

	select b.Genre,sum(o.Quantity) as total_books_sold
	from Orders o
	Join Books b on o.book_id=b.book_id group by Genre;


	-- Q2 Find the average price of books in the "Fantasy" genre:
	select Genre , avg(price) as avg_price
	from books b where Genre='Fantasy' group by Genre;

	-- Q3 List customers who have placed at least 2 orders:
	select  o.customer_id, name ,quantity as No_of_Orders from customers c join orders o on c.customer_id=o.customer_id where quantity>1;

	-- Q4 Find the most frequently ordered book:
	select  o.book_id,b.title,count(o.order_id) as order_count from orders o join books b on o.book_id=b.book_id group by o.book_id,b.title order by order_count DESC ;
	
	-- Q5 Show the top 3 most expensive books of 'Fantasy' Genre :
	select b.title ,o.quantity , b.genre from books b join orders o on b.book_id=o.book_id where b.genre='Fantasy' group by o.book_id ,b.genre,b.title ,order_id order by (o.order_id) desc; 

	-- Q6 Retrieve the total quantity of books sold by each author:
	select b.author ,sum(o.quantity) as  total_books_sold from orders o join books b on o.book_id=b.book_id group by author order by total_books_sold desc;
	
	-- Q7 List the cities where customers who spent over $30 are located:
	select c.city,o.total_amount from customers c join orders o on c.customer_id=o.customer_id  where o.total_amount>30 order by o.total_amount desc;

	-- Q8 Find the customer who spent the most on orders:
	select c.name, sum(o.total_amount) as total_spent 
	from orders o join customers c on o.customer_id=c.customer_id group by c.name order by total_spent desc;

	-- Q9 Calculate the stock remaining after fulfilling all orders:
	select b.title,b.stock ,coalesce(sum(o.quantity),0) as order_quantity , (b.stock-coalesce(sum(o.quantity),0)) as remaining_stock
	from books b left join orders o on b.book_id=o.book_id group by b.book_id  order by b.book_id; 
	







