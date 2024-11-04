%{
Title:PGM_TEAM
Authors:Asa Fowler, Bryan Le
Date:October 27, 2024
Summary:
%}

function [] = PGM_TEAM()

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
    %xlswrite('Cybersecurity.xlsx', Sheet);

    SheetEncoded = {'Patient'; 'Gender'; 'DOB'; 'Children'; 'Allergies'; 'Prescriptions'};
    SheetEncrypt = {'Patient'; 'Gender'; 'DOB'; 'Children'; 'Allergies'; 'Prescriptions'};

    dataamt = size(Sheet, 1);

    function [] = WriteEncoded(Cell)
        [encoded, keys] = Encoder_TEAM(Sheet(:, Cell)');
        Sheet(1:dataamt, Cell) = encoded;
        Sheet((dataamt + 1):(2 * dataamt), Cell) = keys;
    endfunction

    function Cell = ReadEncoded(ColumnN)
        Cell = Decoder_TEAM(Sheet((dataamt+1):(dataamt*2), ColumnN)', Sheet((dataamt + 1):(2 * dataamt), ColumnN)');
    endfunction

    function [] = WriteEncrypted(ColumnN)
        [encrypted, keys] = Encoder_TEAM(Sheet(:, ColumnN)');
        disp(encrypted(1, 1:dataamt))
        Sheet{1:dataamt * 4, ColumnN} = [Sheet(:, ColumnN) repelem('', dataamt * 4 - size(Sheet(:, ColumnN), 2))]
        Sheet((dataamt * 2 + 1):(dataamt * 3), ColumnN) = encrypted(1:dataamt, 1);
        Sheet((dataamt*3 + 1):(4 * dataamt), ColumnN) = keys;
    endfunction

    function Cell = ReadEncrypted(ColumnN)
        Cell = Decrypt_TEAM(Sheet((dataamt * 2 + 1):(dataamt * 3), ColumnN)', Sheet((dataamt * 3 + 1):(4 * dataamt), ColumnN)');
    endfunction

    for i = 2:(size(Sheet, 2) - 2)
        WriteEncoded(i)
        % WriteEncrypted(i)
    endfor
    

    % xlswrite('Cybersecurity.xlsx', Sheet);
    disp(Sheet)

    m = ReadEncoded(2)
    % m = ReadEncrypted(2)

    %Crete a new patient or read patient data

    % function[] = PGM_TEAM()
    Option = questdlg('Create or read patient data? ', 'Menu', 'Create', 'Read', 'Read');

    switch Option
        case 'Create'

            prompts = {'Patient' 'Gender' 'DOB' 'Children' 'Allergies' 'Prescriptions'};
            PatientData = inputdlg(prompts, 'Create Patient');
            % xlswrite('Patients.xlsx', );
            % xlswrite('Patients.xlsx', 'Encoded', );
            EncodedCell = Encoder_TEAM(PatientData)
            % xlswrite('Cybersecurity.xlsx', EncodedCell, 'Encoded (A)');
            Sheet{1, :} = EncodedCell

        case 'Read'
            d = dir;
            patients = Sheet(1, 2:size(Sheet, 2));
            [indx, isSelected] = listdlg('Name', 'Patient Selection', ...
                'PromptString', {'Select a patient.'}, ...
                'SelectionMode', 'single', ...
                'ListString', patients);

            if isSelected

                for i = 2:size(Sheet, 2)

                    if indx[1] == i + 1
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

        otherwise
            exitChoice = input('Exit? (Yes/No)', 's')
            %exitChoice = questdlg('Exit program? ', 'End', 'Yes', 'No', 'Yes');

            if exitChoice == 'No'
                PGM_TEAM()
            endif

    endswitch

endfunction

%CybersecurityA('abc', 1)

%{
start "C:\Users\ble1\AppData\Local\Programs\GNU Octave\Octave-9.2.0\mingw64\bin\octave-cli.exe"
%}
