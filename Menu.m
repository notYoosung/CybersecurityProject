Sheet = {...
  'Patient',       'LUKE SKYWALKER', 'LEIA ORGANA', 'HAN SOLO';
  'Gender',        'Male',           'Female',      'Male';
  'DOB',           '1965-11-05',     '1973-10-13',  '1965-12-15';
  'Children',      '2',              '0',           '1';
  'Allergies',     'Grass, Mold',    'None',        'Carbonite, Wookie dander';
  'Prescriptions', 'Zocor, Daforce', 'None',        'Cymbalta';
};


Option = questdlg('Create or read patient data? ', 'Menu', 'Create', 'Read', 'Read');

switch Option
    case 'Create'

        prompts = {'Patient' 'Gender' 'DOB' 'Children' 'Allergies' 'Prescriptions'};
        PatientData = inputdlg(prompts, 'Create Patient')'
        
        Sheet(size(Sheet, 1) + 1, :) = Encoder_TEAM(PatientData);



        for i = 2:size(PatientData, 2)

            if indx[1] == i + 1
                fprintf('Patient Data:\n')

                for j = 1:size(PatientData, 1)
                    fprintf('\t%s\n', PatientData{j, i})
                endfor

                break
            endif

        endfor
    case 'Read'
        patients = {'a' 'b' 'c'}
        [indx, isSelected] = listdlg('Name', 'Patient Selection', ...
            'PromptString', {'Select a patient.'}, ...
            'SelectionMode', 'single', ...
            'ListString', patients);

        if isSelected

            for i = 2:size(Sheet, 2)

                if indx[1] == i + 1
                    fprintf('Patient Data:\n')

                    for j = 1:size(Sheet, 1)
                        fprintf('\t%s\n', Sheet{j, i})
                    endfor

                    break
                endif

            endfor

        else
            fprintf('exited')
        endif

    otherwise
        exitChoice = questdlg('Exit program? ', 'End', 'Yes', 'No', 'Yes');

        if exitChoice == 'No'
            PGM_TEAM()
        endif

endswitch
