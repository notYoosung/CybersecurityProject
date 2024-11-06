%{
      Title:    PGM_TEAM
    Authors:    Asa Fowler, Bryan Le
       Date:    October 27, 2024
    Summary:    
%}

function[Sheet] = PGM_TEAM()

clear;
clc;
pkg load io;
%[num, txt, raw]
%[_, Headers, _] = xlsread('Cybersecurity.xlsx', 'Sheet1', 'A1:A6')
%txt(1:1,2:3)
%[_, Total, TotalRaw] = xlsread('Cybersecurity.xlsx', 'Sheet1', "")


Sheet = {...
  'Patient',       'LUKE SKYWALKER', 'LEIA ORGANA', 'HAN SOLO';
  'Gender',        'Male',           'Female',      'Male';
  'DOB',           '1965-11-05',     '1973-10-13',  '1965-12-15';
  'Children',      '2',              '0',           '1';
  'Allergies',     'Grass, Mold',    'None',        'Carbonite, Wookie dander';
  'Prescriptions', 'Zocor, Daforce', 'None',        'Cymbalta';
};
xlswrite('Cybersecurity.xlsx', Sheet);

SheetEncoded = { 'Patient'; 'Gender'; 'DOB'; 'Children'; 'Allergies'; 'Prescriptions' };

dataamt = size(Sheet, 1);

for i = 2:(size(Sheet, 2)-2)
    [encoded, keys] = Encoder_TEAM(Sheet(:, i)');
    SheetEncoded(1:dataamt, i) = encoded;
    SheetEncoded((dataamt+1):(2*dataamt), i) = keys;

endfor

    function [] = WriteEncoded(Cell, Col)
        [encoded, keys] = Encoder_TEAM(Cell);
        Sheet((    dataamt + 1):(2 * dataamt), Col) = encoded;
        Sheet((2 * dataamt + 1):(3 * dataamt), Col) = keys;
    endfunction

    function Cell = ReadEncoded(ColumnN)
        Cell = Decoder_TEAM(Sheet((dataamt+1):(dataamt*2), ColumnN)', Sheet((dataamt + 1):(2 * dataamt), ColumnN)');
    endfunction

    function [] = WriteEncrypted(Cell, ColumnN)
        [encrypted, keys] = Encoder_TEAM(Cell);
        Sheet((3 * dataamt + 1):(4 * dataamt), ColumnN) = encrypted(1, 1:dataamt);
        Sheet((4 * dataamt + 1):(5 * dataamt), ColumnN) = keys;
    endfunction

    function Cell = ReadEncrypted(ColumnN)
        Cell = Decrypt_TEAM(Sheet((dataamt * 2 + 1):(dataamt * 3), ColumnN)', Sheet((dataamt * 3 + 1):(4 * dataamt), ColumnN)');
    endfunction
    
    for i = 2:(size(Sheet, 2) - 2)
        WriteEncoded(Sheet(1:dataamt, i)', i)
        WriteEncrypted(Sheet(1:dataamt, i)', i)
    endfor


%m = ReadEncoded(2)


%Crete a new patient or read patient data


% function[] = PGM_TEAM()
Option = questdlg('Create or read patient data? ', 'Menu', 'Create', 'Read', 'Read');
Option = 'Create'
switch Option
  case 'Create'

    prompts = {'Patient' 'Gender' 'DOB' 'Children' 'Allergies' 'Prescriptions'};
    PatientData = inputdlg(prompts, 'Create Patient');
    PatientData = {'Patient' 'Gender' 'DOB' 'Children' 'Allergies' 'Prescriptions'};
    % xlswrite('Patients.xlsx', );
    % xlswrite('Patients.xlsx', 'Encoded', );
    [EncodedCell, RotationCell] = Encoder_TEAM(PatientData)
    % xlswrite('Cybersecurity.xlsx', EncodedCell, 'Encoded (A)');
    WriteEncoded(EncodedCell, size(Sheet, 2))
    disp(Sheet)
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
  otherwise
    exitChoice = input('Quit/Restart?', 's')
    %exitChoice = questdlg('Quit/Restart?', 'End of Program', 'Quit', 'Restart', 'Quit');

    switch exitChoice
        case 'Quit'
            fprintf('Thank')
        case 'Restart'
            PGM_TEAM()
    endswitch
    
endswitch


endfunction


%CybersecurityA('abc', 1)

%{
start "C:\Users\ble1\AppData\Local\Programs\GNU Octave\Octave-9.2.0\mingw64\bin\octave-cli.exe"
%}