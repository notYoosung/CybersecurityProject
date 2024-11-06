%{
Title:PGM_TEAM
Authors:Asa Fowler, Bryan Le
Date:October 27, 2024
Summary:
%}
function [Sheet] = PGM_TEAM()
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
    % xlswrite('Cybersecurity.xlsx', Sheet);

    SheetEncoded = {'Patient'; 'Gender'; 'DOB'; 'Children'; 'Allergies'; 'Prescriptions'};

    dataamt = size(Sheet, 1);
    
    function [] = WriteXlsx(Cell)
        for i = 1:size(Cell, 1)
            for ii = 1:size(Cell, 2)
                xlswrite('Cybersecurity.xlsx', cell2mat(Cell'));
            endfor
        endfor
    endfunction 

    function [] = WriteEncoded(Cell, ColumnN)
        [encoded, keys] = Encoder_TEAM(Cell);
        Sheet((dataamt + 1):(2 * dataamt), ColumnN) = encoded;
        Sheet((2 * dataamt + 1):(3 * dataamt), ColumnN) = keys;
        % xlswrite('Cybersecurity.xlsx', cell2csv(Cell'));
        
    endfunction

    function Cell = ReadEncoded(ColumnN)
        Cell = Decoder_TEAM(Sheet((dataamt + 1):(2 * dataamt), ColumnN)', Sheet((2 * dataamt + 1):(3 * dataamt), ColumnN)');
    endfunction

    function [] = WriteEncrypted(Cell, ColumnN)
        [encrypted, keys] = Encoder_TEAM(Cell);
        Sheet((3 * dataamt + 1):(4 * dataamt), ColumnN) = encrypted;
        Sheet((4 * dataamt + 1):(5 * dataamt), ColumnN) = keys;
    endfunction

    function Cell = ReadEncrypted(ColumnN)
        Cell = Decrypt_TEAM(Sheet((dataamt * 2 + 1):(dataamt * 3), ColumnN)', Sheet((dataamt * 3 + 1):(4 * dataamt), ColumnN)');
    endfunction

    function [] = WriteSheet(Cell, ColumnN)
        Sheet(1:dataamt, ColumnN) = Cell;
        WriteEncrypted(Cell, ColumnN);
        WriteEncoded(Cell, ColumnN);
    endfunction

    for i = 2:(size(Sheet, 2))
        WriteEncoded(Sheet(1:dataamt, i)', i);
        WriteEncrypted(Sheet(1:dataamt, i)', i);
    endfor

    % xlswrite('Cybersecurity.xlsx', Sheet);
    %m = ReadEncoded(2)

    % m = ReadEncoded(2)
    % m = ReadEncrypted(2)

    Option = questdlg('Create or read patient data? ', 'Menu', 'Create', 'Read', 'Read');
    % Option = 'Create'
    switch Option
        case 'Create'

            prompts = {'Patient' 'Gender' 'DOB' 'Children' 'Allergies' 'Prescriptions'};
            PatientData = inputdlg(prompts, 'Create Patient');
            % PatientData = prompts
            % xlswrite('Patients.xlsx', );
            % xlswrite('Patients.xlsx', 'Encoded', );
            EncodedCell = Encoder_TEAM(PatientData);
            % xlswrite('Cybersecurity.xlsx', EncodedCell, 'Encoded (A)');
            WriteSheet(PatientData, size(Sheet, 2) + 1);
        case 'Read'
            patients = Sheet(1, 2:size(Sheet, 2));
            [indx, isSelected] = listdlg('Name', 'Patient Selection', ...
                'PromptString', {'Select a patient.'}, ...
                'SelectionMode', 'single', ...
                'ListString', patients);

            if isSelected
                for i = 2:size(Sheet, 2)
                    if indx == i - 1
                        fprintf('Patient Data:\n')

                        for j = 1:dataamt
                            fprintf('\t%10s:\t %s\n', char(Sheet(j, 1)), char(Sheet(j, i)))
                        endfor
                        break
                    endif
                endfor
            else
                fprintf('exited')
            endif

    endswitch

    % exitChoice = input('Exit? (Yes/No)', 's')
    exitChoice = questdlg('', 'End of Program', 'Quit', 'Restart', 'Quit');

    % xlswrite('Cybersecurity.xlsx', Sheet)

    switch exitChoice
        case 'Quit'
            fprintf('Session ended\n')
        case 'Restart'
            PGM_TEAM();
    endswitch

endfunction

%CybersecurityA('abc', 1)

%{
start "C:\Users\ble1\AppData\Local\Programs\GNU Octave\Octave-9.2.0\mingw64\bin\octave-cli.exe"
%}
