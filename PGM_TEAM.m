%{
      Title:    Cybersecurity Project
    Authors:    Asa Fowler, Bryan Le
       Date:    October 27, 2024
    Summary:    
%}
function [excelSheet] = PGM_TEAM ()
    clear;
    clc;
    pkg load io;


    %[num, txt, raw]
    %[_, Headers, _] = xlsread('Cybersecurity.xlsx', 'Sheet1', 'A1:A6')
    %txt(1:1,2:3)
    %[_, Total, TotalRaw] = xlsread('Cybersecurity.xlsx', 'Sheet1', "")


    excelSheet = {...
        'Patient', 'LUKE SKYWALKER', 'LEIA ORGANA', 'HAN SOLO';
        'Gender', 'Male', 'Female', 'Male';
        'DOB', '1965-11-05', '1973-10-13', '1965-12-15';
        'Children', '2', '0', '1';
        'Allergies', 'Grass, Mold', 'None', 'Carbonite, Wookie dander';
        'Prescriptions', 'Zocor, Daforce', 'None', 'Cymbalta';
    };
    % xlswrite('Cybersecurity.xlsx', excelSheet);

    % SheetEncoded = {'Patient'; 'Gender'; 'DOB'; 'Children'; 'Allergies'; 'Prescriptions'};


    function Chars = ColLetter(n)
        Chars = '';

        while (n > 0)
            Chars = [char(double('A') + mod(n - 1, 26)), Chars];
            n = int16(n / 26);
        endwhile

    endfunction

    dataamt = size(excelSheet, 1);
    
    function [] = WriteXlsx (Cell)
        for i = 1:size(Cell, 1)
            for ii = 1:size(Cell, 2)
                C = [ColLetter(ii) sprintf('%0.0f', i)]
                disp(Cell{i, ii})
                xlswrite('Cybersecurity.xlsx', [ Cell{i, ii} ], 'Sheet1', C);
            endfor
        endfor
    endfunction
    % WriteXlsx (excelSheet)

    function [] = WriteEncoded (Cell, ColumnN)
        [encoded, keys] = Encoder_TEAM (Cell);
        excelSheet((dataamt + 1):(2 * dataamt), ColumnN) = encoded;
        excelSheet((2 * dataamt + 1):(3 * dataamt), ColumnN) = keys;
        xlswrite('Cybersecurity.xlsx', cell2mat(Cell));
        
    endfunction

    function Cell = ReadEncoded (ColumnN)
        Cell = Decoder_TEAM (excelSheet((dataamt + 1):(2 * dataamt), ColumnN)', excelSheet((2 * dataamt + 1):(3 * dataamt), ColumnN)');
    endfunction

    function [] = WriteEncrypted (Cell, ColumnN)
        [encrypted, keys] = Encoder_TEAM (Cell);
        excelSheet((3 * dataamt + 1):(4 * dataamt), ColumnN) = encrypted;
        excelSheet((4 * dataamt + 1):(5 * dataamt), ColumnN) = keys;
    endfunction

    function Cell = ReadEncrypted (ColumnN)
        Cell = Decrypt_TEAM (excelSheet((dataamt * 2 + 1):(dataamt * 3), ColumnN)', excelSheet((dataamt * 3 + 1):(4 * dataamt), ColumnN)');
    endfunction

    function [] = WriteSheet (Cell, ColumnN)
        excelSheet(1:dataamt, ColumnN) = Cell;
        WriteEncrypted (Cell, ColumnN);
        WriteEncoded (Cell, ColumnN);
    endfunction

    for i = 2:(size(excelSheet, 2))
        WriteEncoded (excelSheet(1:dataamt, i)', i);
        WriteEncrypted (excelSheet(1:dataamt, i)', i);
    endfor

    % xlswrite('Cybersecurity.xlsx', excelSheet);
    %m = ReadEncoded (2)

    % m = ReadEncoded (2)
    % m = ReadEncrypted (2)

    option = questdlg('Create or read patient data? ', 'Menu', 'Create', 'Read', 'Read');
    % option = 'Create'
    switch option
        case 'Create'

            prompts = {'Patient' 'Gender' 'DOB' 'Children' 'Allergies' 'Prescriptions'};
            patientData = inputdlg(prompts, 'Create Patient');
            encodedCell = Encoder_TEAM (patientData);

            fprintf('Patient Data:\n')

            for j = 1:dataamt
                fprintf('\t%10s:\t %s\n', char(excelSheet(j, 1)), char(excelSheet(j, size(excelSheet, 2))))
            endfor
            
            WriteSheet (patientData, size(excelSheet, 2) + 1);
        case 'Read'
            patients = excelSheet(1, 2:size(excelSheet, 2));
            [indx, isSelected] = listdlg('Name', 'Patient Selection', ...
                'PromptString', {'Select a patient.'}, ...
                'SelectionMode', 'single', ...
                'ListString', patients);

            if isSelected
                fprintf('Patient Data:\n')

                for j = 1:dataamt
                    fprintf('\t%10s:\t %s\n', char(excelSheet(j, 1)), char(excelSheet(j, indx + 1)))
                endfor
            else
                fprintf('exited')
            endif

    endswitch

    exitChoice = questdlg('', 'End of Program', 'Quit', 'Restart', 'Quit');

    switch exitChoice
        case 'Quit'
            fprintf('Session ended\n')
        case 'Restart'
            PGM_TEAM ();
    endswitch

endfunction
