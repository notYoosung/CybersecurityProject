clear;
clc;
pkg load io;
%[num, txt, raw]
%[_, Headers, _] = xlsread('Cybersecurity.xlsx', 'Sheet1', 'A1:A6')
%txt(1:1,2:3)
%[_, Total, TotalRaw] = xlsread('Cybersecurity.xlsx', 'Sheet1', "")


Sheet = {...
  'Patient', 'LUKE SKYWALKER', 'LEIA ORGANA', 'HAN SOLO';
  'Gender', 'Male', 'Female', 'Male';
  'DOB', '1965-11-05', '1973-10-13', '1965-12-15';
  'Children', '2', '0', '1';
  'Allergies', 'Grass, Mold', 'None', 'Carbonite, Wookie dander';
  'Prescriptions', 'Zocor, Daforce', 'None', 'Cymbalta';
};
xlswrite('Cybersecurity.xlsx', Sheet);



%Crete a new patient or read patient data


% function[] = PGM_TEAM()
Option = questdlg('Create or read patient data? ', 'Menu', 'Create', 'Read', 'Read');
switch Option
  case 'Create'

    prompts = {'Patient' 'Gender' 'DOB' 'Children' 'Allergies' 'Prescriptions'};
    PatientData = inputdlg(prompts, 'Create Patient');
    % xlswrite('Patients.xlsx', );
    % xlswrite('Patients.xlsx', 'Encoded', );
    Rotation = randi(26);
    EncodedCell = Encode(PatientData, Rotation)
    xlswrite('Cybersecurity.xlsx', EncodedCell, 'Encoded (A)');


  case 'Read'
    d = dir;
    patients = Sheet(2:size(Sheet, 1), 1);
    [indx, isSelected] = listdlg('Name', 'Patient Selection', ...
        'PromptString', {'Select a patient.'}, ...
        'SelectionMode', 'single', ...
        'ListString', patients);
    if isSelected
        for i = 2:size(Sheet, 1)
            if indx[1] == i+1
                fprintf('Patient Data:\n')
                for j = 1:size(Sheet, 2)
                    fprintf('\t%10s:\t %s\n', char(Sheet(1, j)), char(Sheet(i, j)))
                endfor
                break
            endif
        endfor
    else
        fprintf('exited')
    endif
endswitch

% endfunction


%CybersecurityA('abc', 1)

%{
start "C:\Users\ble1\AppData\Local\Programs\GNU Octave\Octave-9.2.0\mingw64\bin\octave-cli.exe"
%}