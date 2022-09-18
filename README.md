# SpringBootPostgreSQLSampleApp

#	How To

##	Prerequisite

•	JDK 11 or above

•	Gradle 5+ or above

•	PostgreSQL 14.5 or above

##	Initial set-up of Spring Boot and PostgreSQL

Set up the database with the required database objects. 
Open the sql file which is present inside root directory of the project named testdb.sql. Execute the sql file and the required database objects will be created.

##	Adding required dependencies for PostgreSQL

Added the below dependencies in build.gradle file of our application to start working with PostgreSQL as shown below:
```
dependencies {
   implementation ("org.springframework.boot:spring-boot-starter-web")
   implementation ("org.springframework.boot:spring-boot-starter-data-jpa")
   …
   implementation ("org.postgresql:postgresql")
   testImplementation ("org.springframework.boot:spring-boot-starter-test")
}
```
##	Modify config file

Modify the application.yaml (/src/main/resoorces/application.yaml) file to include the database connection attributes to make a connection to the created PostgreSQL database as below:
```
spring:
  jpa:
    database: POSTGRESQL
    show-sql: true
    hibernate:
      ddl-auto: update
      dialect: org.hibernate.dialect.PostgreSQL81Dialect
      naming_strategy: org.hibernate.cfg.ImprovedNamingStrategy
  datasource:
    platform: postgres
    url: jdbc:postgresql://localhost:5432/testdb
    username: postgres
    password: postgres
```
##	Define Entity, Repository, Service and Controller

We then created the necessary classes like entity, repository, service and controller. In the entity class (com.sample.app.model.Employee), we use necessary annotations from javax.persistence package as shown below:

```
...
import javax.persistence.*;
import java.io.Serializable;
@Entity
@Table(name = "employee")
public class Employee implements Serializable {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private long id;
    private String name;
     ...
```
In the repository class (com.sample.app.repository.EmployeeRepository), we extend the JpaRepository as seen in the below code excerpt: 
```
package com.sample.app.repository;
...
@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Long> { }
...
```
In the service implementation class (com.sample.app.service.EmployeeService) , we have the repository autowired and the required methods for the CRUD operations on the Employee object. These methods are called from the controller class. 
Code excerpt below:

```
...
public interface EmployeeService {
    void saveEmployee(Employee employee);
    void updateEmployee(Employee employee);
    Employee getEmployeeById(long id);
    List<Employee> getEmployees();
    void deleteEmployee(Long id);
}
```
...
Then we create the controller class with is a REST controller which contain various methods for performing operations on Employee with appropriate request mappings. Code excerpt below:
```
...
@RestController
public class EmployeeController {
	private final Logger LOG = LoggerFactory.getLogger(getClass());
	@Autowired
	EmployeeService employeeService;
	@PostMapping("/employees")
	public Employee saveEmployee(@RequestBody Employee employee) {
		employeeService.saveEmployee(employee);
		return employee;
	}
	@PutMapping("/employees")
	public Employee updateEmployee(@RequestBody Employee employee) {
		employeeService.saveEmployee(employee);
		return employee;
	}
	...
```
##	Build and run the executable application jar

We can now run the application from command line or build an executable JAR file that contains all necessary dependencies, classes and resources to run that. Commands to build and run as below:
```
gradlew clean build
cd build/libs
java – jar <jar-name>.jar
```

##	Test the application

Now as the application is running, we can test the http endpoints in the controller class using curl or a tool like Postman. Create a POST request in Postman with URL: 
http://localhost:8090/employees
Pass the below json as body to the request selecting JSON in the body section of the http request.
```
{
    "name": "Sriram",
    "department": "IT",
    "age": "29"
}
```
This will create an employee in the database. Likewise, we can try out other http endpoints to test out the CRUD operations.
