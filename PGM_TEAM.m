clear;
clc;
pkg load io;
[num, txt, raw] = xlsread('CyberSecurity.xlsx', 'Sheet1');
%txt(1:1,2:3)

InitialPatients = {
  struct(
    'Patient', 'LUKE SKYWALKER',
    'Gender', 'Male',
    'DOB', '1965-11-05',
    'Children', '2',
    'Allergies', 'Grass, Mold',
    'Prescriptions', 'Zocor, Daforce'
  ),
  struct(
    'Patient', 'LEIA ORGANA',
    'Gender', 'Female',
    'DOB', '1973-10-13',
    'Children', '0',
    'Allergies', 'None',
    'Prescriptions', 'None'
  ),
  struct(
    'Patient', 'HAN SOLO',
    'Gender', 'Male',
    'DOB', '1965-12-15',
    'Children', '1',
    'Allergies', 'Carbonite, Wookie dander',
    'Prescriptions', 'Cymbalta'
  ),
};
xlswrite('Patients.xlsx', InitialPatients);

%Crete a new patient or read patient data
Option = questdlg('Create or read patient data? ', 'Menu', 'Create', 'Read', 'Read');
switch Option
  case 'Create'

    prompts = {'Patient' 'Gender' 'DOB' 'Children' 'Allergies' 'Prescriptions'};
    PatientData = inputdlg(prompts, 'Create Patient');
    xlswrite('Patients.xlsx', PatientData);
  case 'Read'

endswitch


%CybersecurityA('abc', 1)
