CREATE TABLE departments (
    DeptID VARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL
);

CREATE TABLE encounters (
    EncounterID VARCHAR(20) PRIMARY KEY,
    PatientID VARCHAR(50) NOT NULL,
    EncounterDate DATE NOT NULL,
    EncounterType VARCHAR(50) NOT NULL,
    ProviderID VARCHAR(20) NOT NULL,
    DepartmentID VARCHAR(20) NOT NULL,
    ProcedureCode VARCHAR(50),
    InsertedDate DATE,
    ModifiedDate DATE
);

CREATE TABLE patients (
    ID VARCHAR(50) PRIMARY KEY,
    F_Name NVARCHAR(255) NOT NULL,
    L_Name NVARCHAR(255) NOT NULL,
    M_Name NVARCHAR(255),
    SSN VARCHAR(20) UNIQUE,
    PhoneNumber VARCHAR(50),
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    DOB DATE NOT NULL,
    Address NVARCHAR(500),
    Updated_Date DATE
);

CREATE TABLE providers (
    ProviderID VARCHAR(20) PRIMARY KEY,
    FirstName NVARCHAR(255) NOT NULL,
    LastName NVARCHAR(255) NOT NULL,
    Specialization NVARCHAR(255),
    DeptID VARCHAR(20),
    NPI BIGINT UNIQUE
);

CREATE TABLE transactions (
    TransactionID VARCHAR(20) PRIMARY KEY,
    EncounterID VARCHAR(20) NOT NULL,
    PatientID VARCHAR(50) NOT NULL,
    ProviderID VARCHAR(20) NOT NULL,
    DeptID VARCHAR(20) NOT NULL,
    VisitDate DATE NOT NULL,
    ServiceDate DATE NOT NULL,
    PaidDate DATE,
    VisitType VARCHAR(50),
    Amount DECIMAL(18,2),
    AmountType VARCHAR(50),
    PaidAmount DECIMAL(18,2),
    ClaimID VARCHAR(50),
    PayorID VARCHAR(50),
    ProcedureCode VARCHAR(50),
    ICDCode VARCHAR(50),
    LineOfBusiness VARCHAR(100),
    MedicaidID VARCHAR(50),
    MedicareID VARCHAR(50),
    InsertDate DATE,
    ModifiedDate DATE
);

