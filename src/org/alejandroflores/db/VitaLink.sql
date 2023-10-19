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


##########################################################################################
##########################################################################################
##########################################################################################
#################################PART OF STORED PROCEDURE#################################
##########################################################################################
##########################################################################################


/*##############STORED PROCEDURES SPECIALITYES###############*/
Delimiter $$
	Create procedure sp_AddSpeciality(in nameSpeciality varchar(150))
		Begin
			Insert into Specialityes(nameSpeciality)
				values(nameSpeciality);
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_ListSpeciality()
		Begin
			Select 
				S.idSpeciality,
                S.nameSpeciality
                from Specialityes S;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_SearchSpeciality(in specialityId int)
		Begin
			Select 
				S.idSpeciality,
                S.nameSpeciality
                from Specialityes S where S.idSpeciality = specialityId;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_DeleteSpeciality(in specialityId int)
		Begin
			Delete from Specialityes 
				where idSpeciality = specialityId;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_UpdateSpeciality(in specialityId int, in specialityName varchar(150))
		Begin
			Update Specialityes S
				Set S.nameSpeciality = specialityName
                where S.idSpeciality = specialityId;
        End$$
Delimiter ;


/*##############STORED PROCEDURES PHARMACEUTICALS###############*/

Delimiter $$
	Create procedure sp_addPharmaceutical(in namePharmaceutical varchar(150),
						in addressPharmaceutical varchar(150), in phonePharmaceutical varchar(8))
		Begin
			Insert into Pharmaceuticals (namePharmaceutical, addressPharmaceutical, phonePharmaceutical)
				values(namePharmaceutical, addressPharmaceutical, phonePharmaceutical);
        End$$
Delimiter ;


Delimiter $$
		Create procedure sp_ListPharmaceuticals()
			Begin
				Select
					P.idPharmaceutical,
                    P.namePharmaceutical,
                    P.addressPharmaceutical,
                    P.phonePharmaceutical
                    from Pharmaceuticals P;
            End$$
Delimiter ;


Delimiter $$
	Create procedure sp_SearchPharmaceutical(in pharmaceuticalId int)
		Begin
			Select 
				P.idPharmaceutical,
				P.namePharmaceutical,
				P.addressPharmaceutical,
				P.phonePharmaceutical
				from Pharmaceuticals P where P.idPharmaceutical = pharmaceuticalId;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_DeletePharmaceutical(in pharmaceuticalId int)
		Begin
			Delete from Pharmaceuticals
				where idPharmaceutical = pharmaceuticalId;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_UpdatePharmaceutical(in pharmaceuticalId int, in pharmaceuticalName varchar(150),
						in pharmaceuticalAddress varchar(150), in pharmaceuticalPhone varchar(8))
		Begin
			Update Pharmaceuticals P
				Set P.namePharmaceutical = pharmaceuticalName,
                P.addressPharmaceutical = pharmaceuticalAddress,
                P.phonePharmaceutical = pharmaceuticalName
                where P.idPharmaceutical = pharmaceuticalId;
        End$$
Delimiter ;


/*##############STORED PROCEDURES PATIENTS###############*/

Delimiter $$
	Create procedure sp_AddPatient(in namePatient varchar(150), in lastNamePatient varchar(150),
			in dateOfBirth date, in genderPatient char(1), in addressPatient varchar(150),
			in phonePatient varchar(8), in emailPatient varchar(150))
        Begin
			Insert into Patients(namePatient, lastNamePatient, dateOfBirth, genderParient, addressPatient, phonePatient, emailPatient)
				values(namePatient, lastNamePatient, dateOfBirth, genderParient, addressPatient, phonePatient, emailPatient);
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_ListPatients()
		Begin
			Select
				Pa.idPatient,
                Pa.namePatient,
                Pa.lastNamePatient,
                Pa.dateOfBirth,
                Pa.genderPatient,
                Pa.addressPatient,
                Pa.phonePatient,
                Pa.emailPatient
                from Patients Pa;
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_SearchPatient(in patientId int)
		Begin
			Select
				Pa.idPatient,
                Pa.namePatient,
                Pa.lastNamePatient,
                Pa.dateOfBirth,
                Pa.genderPatient,
                Pa.addressPatient,
                Pa.phonePatient,
                Pa.emailPatient
                from Patients Pa where Pa.idPatient = patientId;	
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_DelimiterPatient(in patientId int)
		Begin
			Delete from Patients
				where idPatient = patientId;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_UpdatePatient(in patientId int,in patientName varchar(150), in patientLastName varchar(150),
				in birthDay date, in patientGender char(1), in patientAddress varchar(150),
				in patientPhone varchar(8), in patientEmail varchar(150))
		Begin
			Update Patients Pa
				Set Pa.namePatient = patientName,
                Pa.lastNamePatient = patientLastName,
                Pa.dateOfBirth = birthDay,
                Pa.genderPatient = patientGender,
                Pa.addressPatient = patientAddress,
                Pa.phonePatient = patientPhone,
                Pa.emailPatient = patientEmail
                where Pa.idPatient = patientId;
        End$$
Delimiter ;

/*##############STORED PROCEDURES MEDICATIONS###############*/

Delimiter $$
	Create procedure sp_AddMedication(in nameMedication varchar(150), in descriptionMedication varchar(200),
				in idPharmaceutical int)
		Begin
			Insert into Medications(nameMedication, descriptionMedication, idPharmaceutical)
				values(nameMedication, descriptionMedication, idPharmaceutical);
        End$$
Delimiter ;

Delimiter $$
	Create procedure sp_ListMedications()
		Begin
			Select
				M.idMedication,
                M.nameMedication,
                M.descriptionMedication,
                M.idPharmaceutical
                from Medications M;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_SearchMedication(in medicationId int)
		Begin
			Select
				M.idMedication,
                M.nameMedication,
                M.descriptionMedication,
                M.idPharmaceutical
                from Medications M where M.idMedication = medicationId;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_DeleteMedication(in medicationId int)
		Begin
			Delete from Medications
				where idMedication = medicationId;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_UpdateMedication(in medicationId int,in medicationName varchar(150),
				in medicationDescription varchar(200), in pharmaceuticalId int)
		Begin
			Update Medications M
				Set M.nameMedication = medicationName,
                M.descriptionMedication = medicationDescription,
                M.idPharmaceutical = pharmaceuticalId
                where M.idMedication = medicationId;
        End$$
Delimiter ;


/*##############STORED PROCEDURES DOCTORS###############*/

Delimiter $$
	Create procedure sp_AddDoctor(in licenseDoctor varchar(20), in nameDoctor varchar(150),
			in lastNameDoctor varchar(150), in idSpeciality int, in dateOfBirth date,
			in genderDoctor char(1), in addressDoctor varchar(150),
            in phoneDoctor varchar(8), in emailDoctor varchar(150))
		Begin
			Insert into Doctors(licenseDoctor, nameDoctor, lastNameDoctor, idSpeciality,
								dateOfBirth, genderDoctor, addressDoctor, phoneDoctor, emailDoctor)
				values (licenseDoctor, nameDoctor, lastNameDoctor, idSpeciality,
								dateOfBirth, genderDoctor, addressDoctor, phoneDoctor, emailDoctor);
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_ListDoctor()
		Begin
			Select
				D.idDoctor,
                D.licenseDoctor,
                D.nameDoctor,
                D.lastNameDoctor,
                D.idSpeciality,
                D.dateOfBirth,
                D.genderDoctor,
                D.addressDoctor,
                D.phoneDoctor,
                D.emailDoctor
                from Doctors D;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_SearchDoctor(in doctorId int)
		Begin
			Select
				D.idDoctor,
                D.licenseDoctor,
                D.nameDoctor,
                D.lastNameDoctor,
                D.idSpeciality,
                D.dateOfBirth,
                D.genderDoctor,
                D.addressDoctor,
                D.phoneDoctor,
                D.emailDoctor
                from Doctors D where D.idDoctor = doctorId;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_DeleteDoctor(in doctorId int)
		Begin
			Delete from Doctors
				where idDoctor = doctorId;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_UpdateDoctor(in doctorId int ,in doctorLicense varchar(20), in doctorName varchar(150),
			in doctorLastName varchar(150), in specialityId int, in birthDay date,
			in doctorGender char(1), in doctorAddress varchar(150),
            in doctorPhone varchar(8), in doctorEmail varchar(150))
		Begin
			Update Doctors D
				Set D.licenseDoctor = doctorLicense,
                D.nameDoctor = doctorName,
                D.lastNameDoctor = doctorLastName,
                D.idSpeciality = specialityId,
                D.dateOfBirth = birthDay,
                D.genderDoctor = doctorGender,
                D.addressDoctor = doctorAddress,
                D.phoneDoctor = doctorPhone,
                D.emailDoctor = doctorEmail
                where D.idDoctor = doctorId;
        End$$
Delimiter ;


/*##############STORED PROCEDURES PRESCRIPTIONS###############*/

Delimiter $$
	Create procedure sp_AddPrescription(in idDoctor int, in idPatient int,in idMedication int, 
			in quantityMedication int, in datePrescription date, in instructions varchar(200))
		Begin
			Insert into Prescriptions(idDoctor, idPatient, idMedication, quantityMedication,
				datePrescription, instructions)
				values(idDoctor, idPatient, idMedication, quantityMedication,
				datePrescription, instructions);
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_ListPrescriptions()
		Begin
			Select
				Pre.idPrescription,
                Pre.idDoctor,
                Pre.idPatient,
                Pre.idMedication,
                Pre.quantityMedication,
                Pre.datePrescription,
                Pre.instructions
                from Prescriptions Pre;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_SearchPrescription(in prescriptionId int)
		Begin
			Select
				Pre.idPrescription,
                Pre.idDoctor,
                Pre.idPatient,
                Pre.idMedication,
                Pre.quantityMedication,
                Pre.datePrescription,
                Pre.instructions
                from Prescriptions Pre where Pre.idPrescription = prescriptionId;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_DeletePrescription(in prescriptionId int)
		Begin
			Delete from Prescriptions
				where idPrescription = prescriptionId;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_UpdatePrescription(in prescriptionId int,in doctorId int, in patientId int,
			in medicationId int, in medicationQuantity int, in prescriptionDate date, 
			in instructionss varchar(200))
		Begin
			Update Prescriptions Pre
				Set Pre.idDoctor = doctorId,
                Pre.idPatient = patientId,
                Pre.idMedication = medicationId,
                Pre.quantityMedication = medicationQuantity,
                Pre.datePrescription = prescriptionDate,
                Pre.instructions = instructionss
				where Pre.idPrescription = prescriptionId;
        End$$
Delimiter ;

/*##############STORED PROCEDURES PAYMENT-METHODS###############*/

Delimiter $$
	Create procedure sp_AddPaymentMethod(in nameMethod varchar(150), in descriptionMethod varchar(150))
		Begin
			Insert into PaymentMethods(nameMethod, descriptionMethod)
				values(nameMethod, descriptionMethod);
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_ListPaymentMethods()
		Begin
			Select
				Pm.idPaymentMethod,
                Pm.nameMethod,
                Pm.descriptionMethod
                from PaymentMethods Pm;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_SearchPaymentMethod(in paymentMethodId int)
		Begin
			Select
				Pm.idPaymentMethod,
                Pm.nameMethod,
                Pm.descriptionMethod
                from PaymentMethods Pm where Pm.idPaymentMethod = paymentMethodId;
        End$$	
Delimiter ;


Delimiter $$
	Create procedure sp_DeletePaymentMethod(in paymentMethodId int)
		Begin
			Delete from PaymentMethods
				where idPaymentMethod = paymentMethodId;
        End$$
Delimiter ;


Delimiter $$
	Create procedure sp_UpdatePaymentMethod(in paymentMethodId int,
				in methodName varchar(150), in methodDescription varchar(150))
		Begin
			Update PaymentMethods Pm
				Set Pm.nameMethod = methodName,
                Pm.descriptionMethod = methodDescription
					where Pm.idPaymentMethod = paymentMethodId;
        End$$
Delimiter ;









