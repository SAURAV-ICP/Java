# SneakerEthics - Ethical Sneakers Shop

SneakerEthics is a web-based platform that promotes sustainable fashion by enabling users to purchase ethically sourced sneakers. The platform provides transparency into supply chain practices and highlights ethical certifications for each product.

## Features

- User authentication with role-based access (admin/user)
- Responsive design using CSS media queries and Flexbox
- Secure session management
- User dashboard for browsing and purchasing sneakers
- Admin dashboard for inventory management
- Search functionality for sneakers
- Ethical certification display for each product

## Technologies Used

- Java EE (Jakarta EE)
- MySQL Database
- JSP (JavaServer Pages)
- CSS3 (Media Queries & Flexbox)
- JavaScript
- JDBC for database connectivity

## Prerequisites

- JDK 17 or higher
- Apache Tomcat 10.0 or higher
- MySQL 8.0 or higher
- Maven 3.8 or higher

## Database Setup

1. Create a new MySQL database:
   ```sql
   CREATE DATABASE sneakerethics;
   ```

2. Use the provided schema.sql file to create the required tables:
   ```sql
   mysql -u root -p sneakerethics < src/main/resources/schema.sql
   ```

## Project Structure

```
SneakerEthics/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── sneakerethics/
│   │   │           ├── controller/
│   │   │           ├── model/
│   │   │           ├── util/
│   │   │           └── filter/
│   │   ├── resources/
│   │   │   └── schema.sql
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       ├── assets/
│   │       │   └── css/
│   │       ├── admin/
│   │       └── user/
└── pom.xml
```

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/sneakerethics.git
   ```

2. Navigate to the project directory:
   ```bash
   cd sneakerethics
   ```

3. Build the project:
   ```bash
   mvn clean install
   ```

4. Deploy the WAR file to Tomcat:
   - Copy the generated WAR file from `target/sneakerethics.war` to Tomcat's `webapps` directory
   - Start Tomcat server

5. Access the application:
   ```
   http://localhost:8080/sneakerethics
   ```

## Configuration

1. Database configuration:
   - Update the database connection details in `DBConnection.java`:
     ```java
     private static final String URL = "jdbc:mysql://localhost:3306/sneakerethics";
     private static final String USER = "your_username";
     private static final String PASSWORD = "your_password";
     ```

## Security Features

- Password encryption for user accounts
- Session management with timeout
- Role-based access control
- Input validation and sanitization
- Prepared statements for SQL queries

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 