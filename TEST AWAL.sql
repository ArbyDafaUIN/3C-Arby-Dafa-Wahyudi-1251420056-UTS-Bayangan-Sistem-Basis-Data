DROP TABLE IF EXISTS viewing CASCADE;
DROP TABLE IF EXISTS registration CASCADE;
DROP TABLE IF EXISTS property_for_rent CASCADE;
DROP TABLE IF EXISTS private_owner CASCADE;
DROP TABLE IF EXISTS client CASCADE;
DROP TABLE IF EXISTS staff CASCADE;
DROP TABLE IF EXISTS branch CASCADE;


CREATE TABLE branch (
    branch_no VARCHAR(4) PRIMARY KEY,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(30) NOT NULL,
    postcode VARCHAR(10) NOT NULL
);


CREATE TABLE staff (
    staff_no VARCHAR(4) PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    position VARCHAR(30),
    sex CHAR(1),
    dob DATE,
    salary NUMERIC(10,2),
    branch_no VARCHAR(4),

    CONSTRAINT fk_staff_branch
        FOREIGN KEY (branch_no)
        REFERENCES branch(branch_no)
);


CREATE TABLE private_owner (
    owner_no VARCHAR(4) PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    address VARCHAR(100),
    tel_no VARCHAR(20)
);


CREATE TABLE client (
    client_no VARCHAR(4) PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    tel_no VARCHAR(20),
    pref_type VARCHAR(20),
    max_rent NUMERIC(10,2)
);


CREATE TABLE property_for_rent (
    property_no VARCHAR(4) PRIMARY KEY,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(30) NOT NULL,
    postcode VARCHAR(10),
    property_type VARCHAR(20),
    rooms INTEGER,
    rent NUMERIC(10,2),
    owner_no VARCHAR(4),
    staff_no VARCHAR(4),
    branch_no VARCHAR(4),

    CONSTRAINT fk_property_owner
        FOREIGN KEY (owner_no)
        REFERENCES private_owner(owner_no),

    CONSTRAINT fk_property_staff
        FOREIGN KEY (staff_no)
        REFERENCES staff(staff_no),

    CONSTRAINT fk_property_branch
        FOREIGN KEY (branch_no)
        REFERENCES branch(branch_no)
);


CREATE TABLE viewing (
    client_no VARCHAR(4),
    property_no VARCHAR(4),
    view_date DATE,
    comments VARCHAR(100),

    PRIMARY KEY (client_no, property_no, view_date),

    CONSTRAINT fk_viewing_client
        FOREIGN KEY (client_no)
        REFERENCES client(client_no),

    CONSTRAINT fk_viewing_property
        FOREIGN KEY (property_no)
        REFERENCES property_for_rent(property_no)
);


CREATE TABLE registration (
    client_no VARCHAR(4),
    branch_no VARCHAR(4),
    staff_no VARCHAR(4),
    date_joined DATE,

    PRIMARY KEY (client_no, branch_no),

    CONSTRAINT fk_registration_client
        FOREIGN KEY (client_no)
        REFERENCES client(client_no),

    CONSTRAINT fk_registration_branch
        FOREIGN KEY (branch_no)
        REFERENCES branch(branch_no),

    CONSTRAINT fk_registration_staff
        FOREIGN KEY (staff_no)
        REFERENCES staff(staff_no)
);


INSERT INTO branch (branch_no, street, city, postcode)
VALUES
('B005', '22 Deer Rd', 'London', 'SW1 4EH'),
('B007', '16 Argyll St', 'Aberdeen', 'AB2 3SU'),
('B003', '163 Main St', 'Glasgow', 'G11 9QX'),
('B004', '32 Manse Rd', 'Bristol', 'BS99 1NZ'),
('B002', '56 Clover Dr', 'London', 'NW10 6EU');


INSERT INTO staff
(staff_no, first_name, last_name, position, sex, dob, salary, branch_no)
VALUES
('SL21', 'John', 'White', 'Manager', 'M', '1945-10-01', 30000, 'B005'),
('SG37', 'Ann', 'Beech', 'Assistant', 'F', '1960-11-10', 12000, 'B003'),
('SG14', 'David', 'Ford', 'Supervisor', 'M', '1958-03-24', 18000, 'B003'),
('SA9', 'Mary', 'Howe', 'Assistant', 'F', '1970-02-19', 9000, 'B007'),
('SG5', 'Susan', 'Brand', 'Manager', 'F', '1940-06-03', 24000, 'B003'),
('SL41', 'Julie', 'Lee', 'Assistant', 'F', '1965-06-13', 9000, 'B005');


INSERT INTO private_owner
(owner_no, first_name, last_name, address, tel_no)
VALUES
('CO46', 'Joe', 'Keogh', '2 Fergus Dr, Aberdeen AB2 7SX', '01224-861212'),
('CO87', 'Carol', 'Farrel', '6 Achray St, Glasgow G32 9DX', '0141-357-7419'),
('CO40', 'Tina', 'Murphy', '63 Well St, Glasgow G42', '0141-943-1728'),
('CO93', 'Tony', 'Shaw', '12 Park Pl, Glasgow G4 0QR', '0141-225-7025');


INSERT INTO client
(client_no, first_name, last_name, tel_no, pref_type, max_rent)
VALUES
('CR76', 'John', 'Kay', '0207-774-5632', 'Flat', 425),
('CR56', 'Aline', 'Stewart', '0141-848-1825', 'Flat', 350),
('CR74', 'Mike', 'Ritchie', '01475-392178', 'House', 750),
('CR62', 'Mary', 'Tregear', '01224-196720', 'Flat', 600);


INSERT INTO property_for_rent
(property_no, street, city, postcode, property_type, rooms, rent,
 owner_no, staff_no, branch_no)
VALUES
('PA14', '16 Holhead', 'Aberdeen', 'AB7 5SU', 'House', 6, 650, 'CO46', 'SA9', 'B007'),
('PL94', '6 Argyll St', 'London', 'NW2 5SU', 'Flat', 4, 400, 'CO87', 'SL41', 'B005'),
('PG4', '6 Lawrence St', 'Glasgow', 'G11 9QX', 'Flat', 3, 350, 'CO40', 'SG37', 'B003'),
('PG36', '2 Manor Rd', 'Glasgow', 'G32 4QX', 'Flat', 3, 375, 'CO93', 'SG37', 'B003'),
('PG21', '18 Dale Rd', 'Glasgow', 'G12', 'House', 5, 600, 'CO87', 'SG37', 'B003'),
('PG16', '5 Novar Dr', 'Glasgow', 'G12 9AX', 'Flat', 4, 450, 'CO93', 'SG14', 'B003');


INSERT INTO viewing
(client_no, property_no, view_date, comments)
VALUES
('CR56', 'PA14', '2004-05-24', 'too small'),
('CR76', 'PG4',  '2004-04-20', 'too remote'),
('CR56', 'PG4',  '2004-05-26', NULL),
('CR62', 'PA14', '2004-05-14', 'no dining room'),
('CR56', 'PG36', '2004-04-28', NULL);


INSERT INTO registration
(client_no, branch_no, staff_no, date_joined)
VALUES
('CR76', 'B005', 'SL41', '2004-01-02'),
('CR56', 'B003', 'SG37', '2003-04-11'),
('CR74', 'B003', 'SG37', '2002-11-16'),
('CR62', 'B007', 'SA9',  '2003-03-07');
