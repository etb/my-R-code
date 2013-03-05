# Employee <- read.table(pipe("pbpaste"), header = T)
Employee <- structure(list(Name = structure(c(3L, 4L, 1L, 2L), .Label = c("George", 
"Harriet", "Harry", "Sally"), class = "factor"), EmpId = c(3415L, 
2241L, 3401L, 2202L), DeptName = structure(c(1L, 2L, 1L, 2L), .Label = c("Finance", 
"Sales"), class = "factor")), .Names = c("Name", "EmpId", "DeptName"
), class = "data.frame", row.names = c(NA, -4L))

# Dept <- read.table(pipe("pbpaste"), header = T)
Dept <- structure(list(DeptName = structure(c(1L, 3L, 2L), .Label = c("Finance", 
"Production", "Sales"), class = "factor"), Manager = structure(c(2L, 
3L, 1L), .Label = c("Charles", "George", "Harriet"), class = "factor")), .Names = c("DeptName", 
"Manager"), class = "data.frame", row.names = c(NA, -3L))

# EmployeeDept <- read.table(pipe("pbpaste"), header = T)
EmployeeDept <- structure(list(Name = structure(c(3L, 4L, 1L, 2L), .Label = c("George", 
"Harriet", "Harry", "Sally"), class = "factor"), EmpId = c(3415L, 
2241L, 3401L, 2202L), DeptName = structure(c(1L, 2L, 1L, 2L), .Label = c("Finance", 
"Sales"), class = "factor"), Manager = structure(c(1L, 2L, 1L, 
2L), .Label = c("George", "Harriet"), class = "factor")), .Names = c("Name", 
"EmpId", "DeptName", "Manager"), class = "data.frame", row.names = c(NA, 
-4L))

merge(Employee, Dept, sort = F)[,c(2:3,1,4)]

EmployeeDept[ order(EmployeeDept$DeptName), ]

                               
df1 <- matrix(c(3,3,6,4,2,3,3,5,7,1), nrow = 5, ncol=2, byrow=TRUE,
               dimnames = list(seq(1, 5, by = 1), c("A", "B")))

df2 <- matrix(c(5,1,6,1,5,8,4,3,9), nrow = 3, ncol=3, byrow=TRUE,
               dimnames = list(seq(1, 3, by = 1), c("B", "C", "D")))
               
df1
df2
merge(df1, df2, sort = F)[,c(2,1,3,4)]

df3 <- matrix(c(1,"a",7,"t",2,"g",4,"c",9,"t"), nrow = 5, ncol=2, byrow=TRUE,
               dimnames = list(seq(1, 5, by = 1), c("A", "B")))

df4 <- matrix(c("c",5,6,"a",7,8,"t",8,9), nrow = 3, ncol=3, byrow=TRUE,
               dimnames = list(seq(1, 3, by = 1), c("B", "C", "D")))
               
df3
df4
merge(df3, df4, sort = F)[,c(2,1,3,4)]
?merge
