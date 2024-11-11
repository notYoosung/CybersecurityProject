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
    clear;
    clc;
    pkg load io;

    excelSheet = {...
        'Patient', 'LUKE SKYWALKER', 'LEIA ORGANA', 'HAN SOLO';
        'Gender', 'Male', 'Female', 'Male';
        'DOB', '1965-11-05', '1973-10-13', '1965-12-15';
        'Children', '2', '0', '1';
        'Allergies', 'Grass, Mold', 'None', 'Carbonite, Wookie dander';
        'Prescriptions', 'Zocor, Daforce', 'None', 'Cymbalta';
    };
    % xlswrite('Cybersecurity.xlsx', excelSheet);

    function Chars = toLetter(n)
        Chars = '';

        while (n > 0)
            Chars = [char(double('A') + mod(n - 1, 26)), Chars];
            n = int16(n / 26);
        end

    end

    dataamt = 6;%size(excelSheet, 1);
    
    function [] = WriteXlsx (dataCell, cellIndex)
        for i = 1:size(dataCell, 1)
            for ii = 1:size(dataCell, 2)
                C = [toLetter(ii+cellIndex) sprintf('%0.0f', i)];
                xlswrite('Cybersecurity.xlsx', [ dataCell{i, ii} ], 'Sheet1', C);
            endfor
        endfor
    endfunction
    % WriteXlsx (excelSheet, 0);
    xlswrite('Cybersecurity.xlsx', excelSheet);

    function [] = WriteEncoded (dataCell, index)
        [encoded, keys] = Encoder_TEAM (dataCell);
        excelSheet((dataamt + 1):(2 * dataamt), index) = encoded;
        excelSheet((2 * dataamt + 1):(3 * dataamt), index) = keys;
        xlswrite('Cybersecurity.xlsx', excelSheet);
        
    endfunction

    function dataCell = ReadEncoded (index)
        dataCell = Decoder_TEAM (excelSheet((dataamt + 1):(2 * dataamt), index)', excelSheet((2 * dataamt + 1):(3 * dataamt), index)');
    endfunction

    function [] = WriteEncrypted (dataCell, index)
        [encrypted, keys] = Encoder_TEAM (dataCell);
        excelSheet((3 * dataamt + 1):(4 * dataamt), index) = encrypted;
        excelSheet((4 * dataamt + 1):(5 * dataamt), index) = keys;
    endfunction

    function dataCell = ReadEncrypted (index)
        dataCell = Decrypt_TEAM (excelSheet((dataamt * 2 + 1):(dataamt * 3), index)', excelSheet((dataamt * 3 + 1):(4 * dataamt), index)');
    endfunction

    function [] = WriteSheet (dataCell, index)
        excelSheet(1:dataamt, index) = dataCell;
        WriteEncrypted (dataCell, index);
        WriteEncoded (dataCell, index);
        xlswrite('Cybersecurity.xlsx', excelSheet);

    endfunction

    for i = 2:(size(excelSheet, 2))
        WriteEncoded (excelSheet(1:dataamt, i)', i);
        WriteEncrypted (excelSheet(1:dataamt, i)', i);
    endfor

    % xlswrite('Cybersecurity.xlsx', excelSheet');

    option = questdlg('Create or read patient data? ', 'Menu', 'Create', 'Read', 'Read');
    % option = 'Create'

    outputMsg = '';

    switch option
        case 'Create'

            prompts = {'Patient' 'Gender' 'DOB' 'Children' 'Allergies' 'Prescriptions'};
            patientData = inputdlg(prompts, 'Create Patient');
            encodedCell = Encoder_TEAM (patientData);

            outputMsg = ['Patient Data:'];

            WriteSheet (patientData, size(excelSheet, 2) + 1);

            for j = 1:dataamt
                outputMsg = [outputMsg; sprintf('%10s:\t %s', char(excelSheet(j, 1)), char(excelSheet(j, size(excelSheet, 2))))];
            endfor
            
        case 'Read'
            patients = excelSheet(1, 2:size(excelSheet, 2));
            [indx, isSelected] = listdlg('Name', 'Patient Selection', ...
                'PromptString', {'Select a patient.'}, ...
                'SelectionMode', 'single', ...
                'ListString', patients);

            if isSelected
                outputMsg = 'Patient Data:\n';

                for j = 1:dataamt
                    outputMsg = [outputMsg sprintf('%15s:\t %s\n', char(excelSheet(j, 1)), char(excelSheet(j, indx + 1)))];
                end
            else
                fprintf('exited')
            end

    end

%create a random string 
s = ['a':'z' '            '];
textString = ['start ' s(randi(length(s),1,16200)) ' end'];
 
 
%create panel1
hPan1 = uipanel('FontSize',12,...
    'BackgroundColor','white',...
    'Position',[0 0 1 6]);
pos = getpixelposition(hPan1);
 
%create textarea1
jTA1 = uicomponent('Parent',hPan1,'style','javax.swing.jtextarea','tag','myObj','Units','pixels',...
    'BackgroundColor',[0.6 0.6 0.6],'Opaque',0);
jTA1.Position = pos;
jTA1.Font = java.awt.Font('Helvetica', java.awt.Font.PLAIN, 22); % font name, style, size
jTA1.Foreground = java.awt.Color(1,1,1);
jTA1.Editable = 0;
jTA1.LineWrap = 1;
jTA1.WrapStyleWord = 1;
jTA1.Text = textString;
%adjust vertical position of jTextArea so the top of it aligns with top edge of figure frame
%you may need to adjust the value of -5145 to match your screen size
jTA1.Position = [pos(1) -5145 0.995*pos(3) pos(4)];
 
%attach and configure scroll panel
hSP1 = attachScrollPanelTo(jTA1);
hSP1.JavaPeer.getVerticalScrollBar.setPreferredSize(java.awt.Dimension(0,0));
 


    exitChoice = questdlg(outputMsg, 'End of Program', 'Quit', 'Restart', 'Quit');

    switch exitChoice
        case 'Quit'
            fprintf('Session ended\n')
        case 'Restart'
            PGM_TEAM ();
    end

end
