function [decryptedOutput] = Decrypt_TEAM(encryptedInput, key)
%{
        Decrypt_TEAM
            Select characters from excrypted char matrices with a key

        Parameters
        ----------
        encryptedInput : char|cell
            Intended to be first output of `Encrypt_TEAM.m`. A Character array or character cell. 
        key : vec|cell
            Intended to be second output of `Encrypt_TEAM.m`. Contains the indecies of the decrypted output.

        Returns
        -------
        decryptedOutput: char|cell
            Same data type as `encryptedInput`.
            
%}

    % Compatibility for either batch-encoding a cell or encoding a single char array
    inputType = class(encryptedInput);
    if strcmp(inputType, 'char')
        encryptedInput = { encryptedInput };
    end
    if strcmp(class(key), 'double')
        key = { num2cell(key) };
    end

    % Declare the output
    decryptedOutput = {};

    % Loop through each input
    for i = 1:size(encryptedInput, 2)
        % Declare respective output
        decryptedOutput{1, i} = '';

        % If there's no key, then skip
        if size(key, 2) == 0
            continue
        endif

        % Index each key as the output
        for j = 1:size(key{1, i}, 2)
            decryptedOutput = [decryptedOutput encryptedInput{1, i}(str2double(key{1, i}{1, j}))];
        endfor

    endfor

    % If data to encode was given as char, output as char
    if strcmp(inputType, 'char')
        decryptedOutput = decryptedOutput{1, 1};
    end

endfunction
