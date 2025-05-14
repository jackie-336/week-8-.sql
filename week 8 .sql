-- Clinic Booking System Database

-- Drop existing tables if they exist
DROP TABLE IF EXISTS Prescription;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Specialty;

-- 1. Specialty Table
CREATE TABLE Specialty (
    specialty_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Doctor Table
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    specialty_id INT NOT NULL,
    FOREIGN KEY (specialty_id) REFERENCES Specialty(specialty_id)
);

-- 3. Patient Table
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE
);

-- 4. Appointment Table
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- 5. Prescription Table
CREATE TABLE Prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    medication TEXT NOT NULL,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- Sample Insertions (Optional Demo Data)
INSERT INTO Specialty (name) VALUES ('Cardiology'), ('Dermatology'), ('General Practice');

INSERT INTO Doctor (full_name, email, phone, specialty_id)
VALUES
('Dr. Alice Smith', 'alice@gmail.com', '1234567890', 1),
('Dr. Bob Jones', 'bob@gmail.com', '1234567891', 2);

INSERT INTO Patient (full_name, email, phone, date_of_birth)
VALUES
('John Doe', 'john@gmail.com', '9876543210', '1990-01-01'),
('Jane Roe', 'jane@gmail.com', '9876543211', '1985-05-15');

INSERT INTO Appointment (patient_id, doctor_id, appointment_date, status)
VALUES (1, 1, '2025-05-20 10:00:00', 'Scheduled'),
       (2, 2, '2025-05-21 11:00:00', 'Completed');

INSERT INTO Prescription (appointment_id, medication, notes)
VALUES (2, 'Amoxicillin 500mg', 'Take twice daily for 7 days');
