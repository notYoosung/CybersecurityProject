%{
      Title:    Cybersecurity Project
    Authors:    Asa Fowler, Bryan Le
       Date:    October 27, 2024
 Instructor:    Professor Williams
     Course:    CENG-1520-02 Programming for Engineers - Fa24
    Summary:    This program can create or read patient data. Data is encoded and encrypted into an excel
                sheet and is additionally returned as a cell matrix for ease of processing.

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
            Create or read patient data. Internally encodes/encrypts and decodes/decrypts data.

        Returns
        -------
        excelSheet: cell
            A copy of the excel sheet
            Rows are patients, columns are data fields
            By default, there are 6 fields (Patient, Gender, DOB, Children, Allergies, Prescriptions)
            Columns 1-6 are unmodified strings (for reference)
                    7-12:  Encoded Strings
                    13-18: Encoded Keys
                    19-24: Encrypted Strings
                    25-30: Encrypted Keys
            Strings with keys can be decoded/decrypted with respective `*_TEAM` functions,
                and wrapper functions are contained with this function for further ease.
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

    % Since octave doesn't support some Matlab functions, these act as a stand-in for data type conversions
    function strOut = _cell2str (cellInput)
        % Loop through the cell and concatenate with a comma between
        strOut = '';
        for i = 1:size(cellInput, 2) - 1
            strOut = [strOut sprintf('%0.0f', cellInput{i}) ','];
        end
        strOut = [strOut sprintf('%0.0f', cellInput{size(cellInput, 2)})];
    end
    function cellOut = _str2cell (strInput)
        % Split by commas
        cellOut = strsplit(strInput, ',');
    end
    % Batch-conversions
    % Essentially loops through each element and runs its repective function on each element
    function cellOut = batch_cell2str (cellInput)
        cellOut = {};
        for i = 1:size(cellInput, 2)
            cellOut{1, i} = _cell2str (cellInput{1, i});
        end
    end
    function cellOut = batch_str2cell (cellInput)
        cellOut = {};
        for i = 1:size(cellInput, 2)
            cellOut{1, i} = _str2cell (cellInput{1, i});
        end
    end

    % Store the amount of key indecies for reference (6 from the prompt, but automatically
    % checking the sheet's dimension may be useful in other cases)
    dataamt = 6;%size(excelSheet, 1);
    
    % Utility functions: Uses the `*_TEAM` functions to process data. More documentation within their respective function files.
    function [] = WriteEncoded (dataCell, index)
        [encoded, keys] = Encoder_TEAM (dataCell);
        excelSheet((    dataamt + 1):(2 * dataamt), index) = encoded;
        excelSheet((2 * dataamt + 1):(3 * dataamt), index) = keys;
    end

    function dataCell = ReadEncoded (index)
        dataCell = Decoder_TEAM (excelSheet((dataamt + 1):(2 * dataamt), index)', excelSheet((2 * dataamt + 1):(3 * dataamt), index)');
    end

    function [] = WriteEncrypted (dataCell, index)
        [encrypted, keys] = Encrypt_TEAM (dataCell);
        excelSheet((3 * dataamt + 1):(4 * dataamt), index) = encrypted;
        excelSheet((4 * dataamt + 1):(5 * dataamt), index) = batch_cell2str (keys);
        % re = Decrypt_TEAM(encrypted, batch_str2cell (batch_cell2str (keys)))
    end

    function dataCell = ReadEncrypted (index)
        dataCell = Decrypt_TEAM (excelSheet((dataamt * 3 + 1):(dataamt * 4), index)', batch_str2cell (excelSheet((dataamt * 4 + 1):(5 * dataamt), index)'));
    end

    % Wrapper function to handle saving data
    function [] = WriteSheet (dataCell, index)
        excelSheet(1:dataamt, index) = dataCell;
        WriteEncrypted (dataCell', index);
        WriteEncoded (dataCell', index);
    end

    % Encrypt and encode the initial patient data
    for i = 2:(size(excelSheet, 2))
        WriteEncoded (excelSheet(1:dataamt, i)', i);
        WriteEncrypted (excelSheet(1:dataamt, i)', i);
    end

    % Prompt a menu
    menuOption = questdlg('Create or read patient data? ', 'Menu', 'Create', 'Read', 'Read');

    switch menuOption
        case 'Create'
            % List out and prompt patient fields
            prompts = {'Patient' 'Gender' 'DOB' 'Children' 'Allergies' 'Prescriptions'};
            promptDimensions = [1,64;1,64;1,64;1,64;1,64;1,64];
            patientData = inputdlg(prompts, 'Create Patient', promptDimensions);

            % Check if user exited
            if length(patientData) ~= 0
                % Handle edge case if empty fields are given
                for iData = 1:size(patientData, 1)
                    if isempty(patientData(iData, 1){1,1})
                        patientData(iData, 1){1,1} = ' '
                    end
                end

                % Output patient information
                fprintf('%15s:\n', 'Patient Data');
                for j = 1:dataamt
                    fprintf('%15s:\t %s\n', char(excelSheet(j, 1)), char(patientData(j, size(patientData, 2))));
                end

                % Save the data
                WriteSheet (patientData, size(excelSheet, 2) + 1);
                xlswrite('Cybersecurity.xlsx', excelSheet); % Not necessary, but good for displaying values while running
            end

        case 'Read'
            % List out patient names and prompt a selection
            patients = excelSheet(1, 2:size(excelSheet, 2));
            [indx, isSelected] = listdlg('Name', 'Patient Selection', ...
                'PromptString', {'Select a patient.'}, ...
                'SelectionMode', 'single', ...
                'ListString', patients);

            if isSelected % Output patient information
                fprintf('%15s:\n', 'Patient Data');
                for j = 1:dataamt
                    fprintf('%15s:\t %s\n', char(excelSheet(j, 1)), char(excelSheet(j, indx + 1)));
                end
            else
                fprintf('Exited')
            end

    end

    % Realized too late that the columns and rows were swapped, but transposing the sheet should function the same.
    % Scripts may be able to be refactored to remove the need to transpose.
    % However, care must be taken as not all data types (such as vectors of strings) transpose the same.
    excelSheet = excelSheet';
    xlswrite('Cybersecurity.xlsx', excelSheet);

    % Request exit
    exitChoice = questdlg('Do you wish to exit or run again?', 'End of Program', 'Quit', 'Restart', 'Quit');

    % Handle restart case
    if strcmp(exitChoice, 'Restart')
        PGM_TEAM ();
    end

end
