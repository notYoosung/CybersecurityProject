clear;
clc;
pkg load io;
%[num, txt, raw]
%[_, Headers, _] = xlsread('Cybersecurity.xlsx', 'Sheet1', 'A1:A6')
%txt(1:1,2:3)
%[_, Total, TotalRaw] = xlsread('Cybersecurity.xlsx', 'Sheet1', "")


Sheet = {...
  'Patient', 'Gender', 'DOB', 'Children', 'Allergies', 'Prescriptions';
  'LUKE SKYWALKER', 'Male', '1965-11-05', '2', 'Grass, Mold', 'Zocor, Daforce';
  'LEIA ORGANA', 'Female', '1973-10-13', '0', 'None', 'None';
  'HAN SOLO', 'Male', '1965-12-15', '1', 'Carbonite, Wookie dander', 'Cymbalta',
}
xlswrite('Cybersecurity.xlsx', Sheet)

S = size(Sheet)


%{
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
%}
%xlswrite('Patients.xlsx', InitialPatients);

%Crete a new patient or read patient data

Option = questdlg('Create or read patient data? ', 'Menu', 'Create', 'Read', 'Read');
Option = 'Read'
switch Option
  case 'Create'

    prompts = {'Patient' 'Gender' 'DOB' 'Children' 'Allergies' 'Prescriptions'};
    PatientData = inputdlg(prompts, 'Create Patient');
    xlswrite('Patients.xlsx', PatientData');
  case 'Read'
    d = dir;
    patients = Sheet(2:size(Sheet, 1), 1)
    [indx, isSelected] = listdlg('Name', 'Patient Selection', ...
        'PromptString', {'Select a patient.'}, ...
        'SelectionMode', 'single', ...
        'ListString', patients);
    indx = [2]
    if ~isSelected
        for i = 2:size(Sheet, 1)
            disp(i)
            if indx[1] == i+1
                disp(Sheet(i, :))
                fprintf('Patient Data:\n')
                for j = 1:size(Sheet, 2)
                    fprintf('\t%s:\t %s\n', char(Sheet(1, j)), char(Sheet(i, j)))
                endfor
                break
            endif
        endfor
    else
        fprintf('exited')
    endif
endswitch


%CybersecurityA('abc', 1)
