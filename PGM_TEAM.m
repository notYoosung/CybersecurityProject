%{
      Title:    Cybersecurity Project
    Authors:    Asa Fowler, Bryan Le
       Date:    October 27, 2024
    Summary:    Create or read patient data.

    Resources:
        Matlab Docs:
            https://www.mathworks.com/help/matlab/
        Octave Docs:
            https://docs.octave.org/interpreter/
        Formatting:
            https://docs.octave.org/v4.0.0/Format-of-Descriptions.html#Format-of-Descriptions
            https://docs.octave.org/v4.0.0/Octave-Sources-_0028m_002dfiles_0029.html#Octave-Sources-_0028m_002dfiles_0029
%}
function [excelSheet] = PGM_TEAM ()
%{
        PGM_TEAM
            Create or read patient data. Internally encodes/decodes data

        Returns
        -------
        excelSheet: cell
            A copy of the excel sheet
%}

    % Housekeeping functions
    clear;
    clc;

    % Necessary for GUI elements
    % Run `pkg install -forge io` to get the module if it didn't come with installation
    pkg load io;

    % To prevent need for downloading a sheet, create data on run
    excelSheet = {...
        'Patient', 'LUKE SKYWALKER', 'LEIA ORGANA', 'HAN SOLO';
        'Gender', 'Male', 'Female', 'Male';
        'DOB', '1965-11-05', '1973-10-13', '1965-12-15';
        'Children', '2', '0', '1';
        'Allergies', 'Grass, Mold', 'None', 'Carbonite, Wookie dander';
        'Prescriptions', 'Zocor, Daforce', 'None', 'Cymbalta';
    };

    % Unused, but tested for 
    % https://stackoverflow.com/questions/181596/how-to-convert-a-column-number-e-g-127-into-an-excel-column-e-g-aa
    function Chars = toLetter(n)
        Chars = '';

        while (n > 0)
            Chars = [char(double('A') + mod(n - 1, 26)), Chars];
            n = int16(n / 26);
        end

    end

    function strOut = _cell2str(cellInput)
        strOut = '';
        for i = 1:size(cellInput, 2) - 1
            strOut = [strOut sprintf('%0.0f', cellInput{i}{1,1}) ','];
        end
        strOut = [strOut sprintf('%0.0f', cellInput{size(cellInput, 2)}{1,1})];
    end
    function cellOut = _str2cell(strInput)
        cellOut = strsplit(strInput, ',');
    end
    function cellOut = cellstr2cell(cellstrInput)
        cellOut = {};
        for i = 1:size(cellstrInput, 2)
            cellOut{1, i} = _str2cell(cellstrInput{1, i});
        end
    end

    % Adjust 
    dataamt = 6;%size(excelSheet, 1);
    
    function [] = WriteXlsx (dataCell, cellIndex)
        for i = 1:size(dataCell, 1)
            for ii = 1:size(dataCell, 2)
                C = [toLetter(ii+cellIndex) sprintf('%0.0f', i)];
                if strcmp(class(dataCell{i, ii}), 'cell')
                    dataCell{i, ii} = _cell2str(dataCell{i, ii})
                end
                disp({ dataCell{i, ii} })
                xlswrite('Cybersecurity.xlsx', { dataCell{i, ii} }, 'Sheet1', C);
            endfor
        endfor
    endfunction
    % WriteXlsx (excelSheet, 0);
    % xlswrite('Cybersecurity.xlsx', excelSheet);

    function [] = WriteEncoded (dataCell, index)
        [encoded, keys] = Encoder_TEAM (dataCell);
        excelSheet((    dataamt + 1):(2 * dataamt), index) = encoded;
        excelSheet((2 * dataamt + 1):(3 * dataamt), index) = keys;
    endfunction

    function dataCell = ReadEncoded (index)
        dataCell = Decoder_TEAM (excelSheet((dataamt + 1):(2 * dataamt), index)', excelSheet((2 * dataamt + 1):(3 * dataamt), index)');
    endfunction

    function [] = WriteEncrypted (dataCell, index)
        [encrypted, keys] = Encrypt_TEAM (dataCell);
        excelSheet((3 * dataamt + 1):(4 * dataamt), index) = encrypted;
        excelSheet((4 * dataamt + 1):(5 * dataamt), index) = _cell2str(keys);
    endfunction

    function dataCell = ReadEncrypted (index)
            disp((excelSheet((dataamt * 4 + 1):(5 * dataamt), index)'))
            disp(cellstr2cell(excelSheet((dataamt * 4 + 1):(5 * dataamt), index)'))
        dataCell = Decrypt_TEAM (excelSheet((dataamt * 3 + 1):(dataamt * 4), index)', cellstr2cell(excelSheet((dataamt * 4 + 1):(5 * dataamt), index)'));
    endfunction
    WriteEncrypted({'q', 'w', 'e', 'r', 't', 'y'}, 3);
    xlswrite('Cybersecurity.xlsx', excelSheet);
    r = ReadEncrypted(3)

    function [] = WriteSheet (dataCell, index)
        excelSheet(1:dataamt, index) = dataCell;
        WriteEncrypted (dataCell, index);
        WriteEncoded (dataCell, index);
        WriteXlsx (excelSheet(:, index), index);
    endfunction

    for i = 2:(size(excelSheet, 2))
        WriteEncoded (excelSheet(1:dataamt, i)', i);
        WriteEncrypted (excelSheet(1:dataamt, i)', i);
        WriteXlsx (excelSheet(:, i), i);
    endfor


    option = questdlg('Create or read patient data? ', 'Menu', 'Create', 'Read', 'Read');

    outputMsg = '';

    switch option
        case 'Create'

            prompts = {'Patient' 'Gender' 'DOB' 'Children' 'Allergies' 'Prescriptions'};
            patientData = inputdlg(prompts, 'Create Patient');
            encodedCell = Encoder_TEAM (patientData);

            fprintf('Patient Data:\n');

            for j = 1:dataamt
                fprintf('%10s:\t %s\n', char(excelSheet(j, 1)), char(excelSheet(j, size(excelSheet, 2))));
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
                    fprintf('%15s:\t %s\n', char(excelSheet(j, 1)), char(excelSheet(j, indx + 1)));
                end
            else
                fprintf('exited')
            end

    end 


    exitChoice = questdlg('Thank you for using the program.', 'End of Program', 'Quit', 'Restart', 'Quit');

    % Realized the columns and rows were swapped, but transposing the sheet should function the same
    excelSheet = excelSheet;
    % xlswrite('Cybersecurity.xlsx', excelSheet);


    switch exitChoice
        case 'Restart'
            PGM_TEAM ();
        case 'Quit'
        otherwise
    end


end
