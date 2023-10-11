Drop database if exists VitaLink;
Create database VitaLink;

Use VitaLink;

Create table Specialityes(
	idSpeciality int not null auto_increment,
    nameSpeciality varchar(150) not null,
    primary key (idSpeciality)
);

Create table Pharmaceuticals(
	idPharmaceutical int not null auto_increment,
    namePharmaceutical varchar(150) not null,
    addressPharmaceutical varchar(150) not null,
    phonePharmaceutical varchar(8) not null,
    primary key (idPharmaceutical)
);

Create table Patients(
	idPatient int not null auto_increment,
    namePatient varchar(150) not null,
    lastNamePatient varchar(150) not null,
    dateOfBirth date not null,
    genderPatient char(1) not null,
    addressPatient varchar(150) not null,
    phonePatient varchar(8) not null,
    emailPatient varchar(150) not null,
    primary key (idPatient)
);

Create table Medications(
	idMedication int not null auto_increment,
    nameMedication varchar(150) not null,
    descriptionMedication varchar(200) not null,
    idPharmaceutical int not null,
    primary key (idMedication),
    constraint FK_Medications_Pharmaceuticals foreign key(idPharmaceutical)
		references Pharmaceuticals(idPharmaceutical)
);

Create table Doctors(
	idDoctor int not null auto_increment,
    licenseDoctor varchar(20) not null,
    nameDoctor varchar(150) not null,
    lastNameDoctor varchar(150) not null,
    idSpeciality int not null,
    dateOfBirth date not null,
    genderDoctor char(1) not null,
    addressDoctor varchar(150) not null,
    phoneDoctor varchar(8) not null,
    emailDoctor varchar(150) not null,
    primary key PK_idDoctor (idDoctor),
    constraint FK_Doctors_Specialityes foreign key (idSpeciality)
		references Specialityes (idSpeciality)
);

Create table Prescriptions(
	idPrescription int not null auto_increment,
    idDoctor int not null,
    idPatient int not null,
    idMedication int not null,
    quantityMedication int not null,
    datePrescription date not null,
    instructions varchar(200) not null,
    primary key PK_idPrescription (idPrescription),
    constraint FK_Prescriptions_Doctors foreign key (idDoctor)
		references Doctors (idDoctor),
	constraint FK_Prescriptions_Patient foreign key (idPatient)
		references Patients (idPatient),
	constraint FK_Prescriptions_Medications foreign key (idMedication)
		references Medications (idMedication)
);

Create table PaymentMethods(
	idPaymentMethod int not null auto_increment,
    nameMethod varchar(150) not null,
    descriptionMethod varchar(150),
    primary key PK_idPaymentMethod (idPaymentMethod)
);

Create table Invoices(
	idInvoice int not null auto_increment,
    idPatient int not null,
    idDoctor int not null,
    dateInvoice date not null,
    amount decimal(10,2) not null,
    serviceDescription varchar(200) not null,
    idPaymentMethod int not null,
    primary key PK_idInvoice (idInvoice),
    constraint FK_Invoices_Patients foreign key (idPatient)
		references Patients (idPatient),
	constraint FK_Invoices_Doctors foreign key (idDoctor)
		references Doctors (idDoctor)
);

Create table StatusAppointments(
	idStatusAppointments int not null auto_increment,
    descriptionStatusAppointments varchar(100) not null,
    primary key PK_idStatusAppointments (idStatusAppointments)
);

Create table Appointments(
	idAppointment int not null auto_increment,
    idDoctor int not null,
    idPatient int not null,
	dateAppointment date not null,
    timeAppointment time not null,
    commets varchar(200) not null,
    idStatusAppointments int not null,
    primary key PK_idAppointment (idAppointment),
    constraint FK_Invoices_Doctors2 foreign key (idDoctor)
		references Doctors (idDoctor),
	constraint FK_Invoices_Patients2 foreign key (idPatient)
		references Patients (idPatient),
	constraint FK_Invoices_StatusAppointments foreign key (idStatusAppointments)
		references StatusAppointments (idStatusAppointments)
);

Create table MedicalHistory(
	idMedicalHistory int not null auto_increment,
    idPatient int not null,
    dateHistory date not null,
    descriptionMedicalHistory varchar(200) not null,
    diagnosis varchar(200) not null,
	treatment varchar(200) not null,
    primary key PK_idMedicalHistory (idMedicalHistory),
    constraint FK_MedicalHistory_Patients foreign key (idPatient)
		references Patients (idPatient)
);

Create table Users(
	idUser int not null auto_increment,
    nameUser varchar(150) not null,
    lastNameUser varchar(150) not null,
    username varchar(50) not null,
    pin varchar(50) not null,
    primary key PK_idUser (idUser)
);

Create table Login (
	idLogin int not null auto_increment,
    userLogin varchar(50) not null,
    pinLogin varchar(50) not null,
    primary key PK_idLogin (idLogin)
);

















