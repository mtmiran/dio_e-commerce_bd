-- inserindo valores na tabela employee
insert into employee values ("John","B","Smith",123456789,"1970-06-20","Houston","M",30000,333445555,5);
insert into employee values ("Franklin","T","Wong",333445555,"1955-12-08","638 Voss, Houston TX","M",40000,888665555,5);
insert into employee values ("Alicia","J","Zelaya",999887777,"1968-01-19","3321 Castle, Spring TX","F",25000,987654321,4);
insert into employee values ("Jennifer","S","Wallace",987654321,"1941-06-20","291 Berry, Bellaire, TX","F",43000,888665555,4);
insert into employee values ("Ahmad","V","Jabbar",987987987,"1969-03-29","980 Dallas, Houston, TX","M",25000,987654321,4);
insert into employee values ("James","E","Borg",888665555,"1937-11-10","450 Stone, Houston, TX","M",55000,NULL,1);
insert into employee values ("Ramesh","K","Narayan",666884444,"1962-09-15","975 Fire Oak, Humble, TX","M",38000,333445555,5);
insert into employee values ("Joyce","A","English",453453453,"1972-07-31","5631 Rice, Houston, TX","F",25000,333445555,5);

-- inserindo valores na tabela department
insert into department values ("Research",5,333445555,"1988-05-22");
insert into department values ("Administration",4,987654321,"1995-01-01");
insert into department values ("Headquarters",1,888665555,"1981-06-19");

-- inserindo valores na tabela dept_location
insert into dept_locations values(1,"Houston");
insert into dept_locations values(4,"Stafford");
insert into dept_locations values(5,"Bellaire");
insert into dept_locations values(5,"Sugarland");
insert into dept_locations values(5,"Houston");

-- inserindo valores na tabela project
insert into PROJECT values("ProductX",1,"Bellaire",5);
insert into PROJECT values("ProductY",2,"Sugarland",5);
insert into PROJECT values("ProductZ",3,"Houston",5);
insert into PROJECT values("Computerization",10,"Stafford",4);
insert into PROJECT values("Reorganization",20,"Houston",1);
insert into PROJECT values("Newbenefits",30,"Stafford",4);

-- inserindo valores na tabela works_on
insert into WORKS_ON values(123456789,1,32.5);
insert into WORKS_ON values(123456789,2,7.5);
insert into WORKS_ON values(666884444,3,40);
insert into WORKS_ON values(453453453,1,20);
insert into WORKS_ON values(453453453,2,20);
insert into WORKS_ON values(333445555,2,10);
insert into WORKS_ON values(333445555,3,10);
insert into WORKS_ON values(333445555,10,10);
insert into WORKS_ON values(333445555,20,10);
insert into WORKS_ON values(999887777,30,30);
insert into WORKS_ON values(999887777,10,10);
insert into WORKS_ON values(987987987,10,35);
insert into WORKS_ON values(987987987,30,5);

-- adicionar restricao de chave estrangeira(fk) em d_no - employee
ALTER TABLE employee ADD CONSTRAINT FOREIGN KEY (d_no) REFERENCES DEPARTMENT(d_number);