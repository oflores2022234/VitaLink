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
    primary key (idMedication)
);













